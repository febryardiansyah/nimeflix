import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/complete_anime_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_complete_anime_state.dart';

class GetCompleteAnimeCubit extends Cubit<GetCompleteAnimeState> {
  GetCompleteAnimeCubit() : super(GetCompleteAnimeInitial());
  final _repo = MainRepo();
  
  Future<void> fetchCompleteAnime()async{
    int _page = 1;
    emit(GetCompleteAnimeLoading());
    try{
      final _res = await _repo.getComplete(page: _page);
      if (_res.statusCode == 200) {
        final _data = List<CompleteAnimeModel>.from(_res.data['animeList'].map((json)=>CompleteAnimeModel.fromJson(json)));
        emit(GetCompleteAnimeSuccess(page: _page+1,data: _data));
      } else {
        emit(GetCompleteAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetCompleteAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }

  Future<void> onScrolling()async{
    final _currentState = state;
    if (_currentState is GetCompleteAnimeSuccess) {
      try{
        final _res = await _repo.getComplete(page: _currentState.page);
        if (_res.statusCode == 200) {
          final _data = List<CompleteAnimeModel>.from(_res.data['animeList'].map((json)=>CompleteAnimeModel.fromJson(json)));
          emit(_data.isEmpty?_currentState.copyWith(data: _currentState.data,page: _currentState.page):
          GetCompleteAnimeSuccess(page: _currentState.page+1,data: _currentState.data + _data));
        } else {
          emit(GetCompleteAnimeFailure(msg: BaseConstants.errorMessage));
        }
      }catch(e){
        print(e);
        emit(GetCompleteAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }
  }
}

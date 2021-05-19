import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/ongoing_anime_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_ongoing_anime_state.dart';

class GetOngoingAnimeCubit extends Cubit<GetOngoingAnimeState> {
  GetOngoingAnimeCubit() : super(GetOngoingAnimeInitial());
  final _repo = MainRepo();

  Future<void> fetchOngoingAnime()async{
    int _page = 1;
    emit(GetOngoingAnimeLoading());
    try{
      final _res = await _repo.getOngoing(page: _page);
      if (_res.statusCode == 200) {
        final _data = List<OngoingAnimeModel>.from(_res.data['animeList'].map((json)=>OngoingAnimeModel.fromJson(json)));
        emit(GetOngoingAnimeSuccess(data: _data,page: _page+1,hasReachedMax: false));
      } else {
        emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }

  Future<void> onScrolling()async{
    final _currentState = state;
    if (_currentState is GetOngoingAnimeSuccess) {
      try{
        final _res = await _repo.getOngoing(page: _currentState.page);
        if (_res.statusCode == 200) {
          final _data = List<OngoingAnimeModel>.from(_res.data['animeList'].map((json)=>OngoingAnimeModel.fromJson(json)));
          emit(_data.isEmpty?_currentState.copyWith(data: _currentState.data,page: _currentState.page,hasReachedMax: true):
          GetOngoingAnimeSuccess(data: _currentState.data+_data,page: _currentState.page+1,hasReachedMax: false));
        } else {
          emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
        }
      }catch(e){
        print('while scrolling err $e');
        emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }
  }
}

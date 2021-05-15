import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/search_result_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'search_anime_state.dart';

class SearchAnimeCubit extends Cubit<SearchAnimeState> {
  SearchAnimeCubit() : super(SearchAnimeInitial());
  final _repo = MainRepo();
  
  Future<void> searchAnime({String query})async{
    emit(SearchAnimeLoading());
    try{
      final _res = await _repo.searchAnime(query: query);
      if (_res.statusCode == 200) {
        final _data = List<SearchResultModel>.from(_res.data['search_results'].map((json)=>SearchResultModel.fromJson(json)));
        emit(SearchAnimeSuccess(data: _data));
      } else {
        emit(SearchAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(SearchAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }
}

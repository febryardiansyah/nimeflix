import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/anime_by_genre_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_anime_by_genre_state.dart';

class GetAnimeByGenreCubit extends Cubit<GetAnimeByGenreState> {
  GetAnimeByGenreCubit() : super(GetAnimeByGenreInitial());
  final _repo = MainRepo();
  
  Future<void> fetchAnimeByGenre({String id})async{
    int _page = 1;
    emit(GetAnimeByGenreLoading());
    try{
      final _res = await _repo.getAnimeByGenre(page: _page,id: id);
      if (_res.statusCode == 200) {
        final _data = List<AnimeByGenreModel>.from(_res.data['animeList'].map((json)=>AnimeByGenreModel.fromJson(json)));
        emit(GetAnimeByGenreSuccess(data: _data,page: _page+1));
      } else {
        emit(GetAnimeByGenreFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetAnimeByGenreFailure(msg: BaseConstants.errorMessage));
    }
  }

  Future<void> onLoading({String id})async{
    final _currentState = state;
    if (_currentState is GetAnimeByGenreSuccess) {
      try{
        final _res = await _repo.getAnimeByGenre(page: _currentState.page,id: id);
        if (_res.statusCode == 200) {
          final _data = List<AnimeByGenreModel>.from(_res.data['animeList'].map((json)=>AnimeByGenreModel.fromJson(json)));
          emit(_data.isEmpty?_currentState.copyWith(data: _currentState.data,page: _currentState.page):
          GetAnimeByGenreSuccess(data: _currentState.data+_data,page: _currentState.page+1));
        } else {
          emit(GetAnimeByGenreFailure(msg: BaseConstants.errorMessage));
        }
      }catch(e){
        print(e);
        emit(GetAnimeByGenreFailure(msg: BaseConstants.errorMessage));
      }
    }
  }
}

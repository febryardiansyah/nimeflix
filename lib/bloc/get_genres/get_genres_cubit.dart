import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/genre_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_genres_state.dart';

class GetGenresCubit extends Cubit<GetGenresState> {
  GetGenresCubit() : super(GetGenresInitial());
  final _repo = HomeRepo();

  Future<void> fetchGenres()async{
    emit(GetGenresLoading());
    try{
      final _res = await _repo.getGenres();
      if (_res.statusCode == 200) {
        final _data = List<GenreModel>.from(_res.data['genreList'].map((json)=>GenreModel.fromJson(json)));
        emit(GetGenresSuccess(data: _data));
      } else {
        emit(GetGenresFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetGenresFailure(msg: BaseConstants.errorMessage));
    }
  }
}

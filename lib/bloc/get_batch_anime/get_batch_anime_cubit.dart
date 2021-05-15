import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/batch_anime_model.dart';
import 'package:nimeflix/repositories/anime_repo.dart';

part 'get_batch_anime_state.dart';

class GetBatchAnimeCubit extends Cubit<GetBatchAnimeState> {
  GetBatchAnimeCubit() : super(GetBatchAnimeInitial());
  final _repo = AnimeRepo();

  Future<void> fetchBatchAnime({String id})async{
    emit(GetBatchAnimeLoading());
    try{
      final _res = await _repo.getBatchAnime(id: id);
      if (_res.statusCode == 200) {
        final _data = BatchAnimeModel.fromJson(_res.data);
        emit(GetBatchAnimeSuccess(data: _data));
      } else {
        emit(GetBatchAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetBatchAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }
}
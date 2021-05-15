import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/episode_model.dart';
import 'package:nimeflix/repositories/anime_repo.dart';

part 'get_eps_anime_state.dart';

class GetEpsAnimeCubit extends Cubit<GetEpsAnimeState> {
  GetEpsAnimeCubit() : super(GetEpsAnimeInitial());
  final _repo = AnimeRepo();

  Future<void> fetchEpsAnime({String id})async{
    emit(GetEpsAnimeLoading());
    try{
      final _res = await _repo.getEpsAnime(id: id);
      if (_res.statusCode == 200) {
        final _data = EpisodeModel.fromJson(_res.data);
        emit(GetEpsAnimeSuccess(data: _data));
      } else {
        emit(GetEpsAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetEpsAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }
}

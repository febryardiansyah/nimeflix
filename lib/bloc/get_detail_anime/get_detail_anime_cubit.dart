import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/detail_anime_model.dart';
import 'package:nimeflix/repositories/anime_repo.dart';

part 'get_detail_anime_state.dart';

class GetDetailAnimeCubit extends Cubit<GetDetailAnimeState> {
  GetDetailAnimeCubit() : super(GetDetailAnimeInitial());
  final _repo = AnimeRepo();

  Future<void> fetchDetailAnime({String id})async{
    emit(GetDetailAnimeLoading());
    try{
      final _res = await _repo.getDetailAnime(id: id);
      if (_res.statusCode == 200) {
        final _data = DetailAnimeModel.fromJson(_res.data);
        emit(GetDetailAnimeSuccess(data: _data));
      }else{
        emit(GetDetailAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetDetailAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/mirror_stream_model.dart';
import 'package:nimeflix/repositories/anime_repo.dart';

part 'get_mirror_stream_state.dart';

class GetMirrorStreamCubit extends Cubit<GetMirrorStreamState> {
  GetMirrorStreamCubit() : super(GetMirrorStreamInitial());
  final _repo = AnimeRepo();

  Future<void> fetchMirrorStream({String animeId,String mirrorId})async{
    emit(GetMirrorStreamLoading());
    try{
      final _res = await _repo.getMirrorStream(animeId: animeId,mirrorId: mirrorId);
      if (_res.statusCode == 200) {
        final _data = MirrorStreamModel.fromJson(_res.data);
        emit(GetMirrorStreamSuccess(data: _data));
      } else {
        emit(GetMirrorStreamFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetMirrorStreamFailure(msg: BaseConstants.errorMessage));
    }
  }
}

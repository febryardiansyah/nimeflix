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
    emit(GetOngoingAnimeLoading());
    try{
      final _res = await _repo.getOngoing();
      if (_res.statusCode == 200) {
        final _data = List<OngoingAnimeModel>.from(_res.data['animeList'].map((json)=>OngoingAnimeModel.fromJson(json)));
        emit(GetOngoingAnimeSuccess(data: _data));
      } else {
        emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetOngoingAnimeFailure(msg: BaseConstants.errorMessage));
    }
  }
}

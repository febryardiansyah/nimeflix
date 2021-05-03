import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/complete_anime_model.dart';
import 'package:nimeflix/models/ongoing_anime_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_home_state.dart';

class GetHomeCubit extends Cubit<GetHomeState> {
  GetHomeCubit() : super(GetHomeInitial());
  final _repo = HomeRepo();

  Future<void> fetchHome()async{
    emit(GetHomeLoading());
    try{
      final _res = await _repo.getHome();
      if (_res.data['status'] == 'success') {
        final _home = _res.data['home'];
        final _ongoingData = List<OngoingAnimeModel>.from(_home['on_going'].map((json)=>OngoingAnimeModel.fromJson(json)));
        final _completeData = List<CompleteAnimeModel>.from(_home['complete'].map((json)=>CompleteAnimeModel.fromJson(json)));
        emit(GetHomeSuccess(ongoingData: _ongoingData,completeData: _completeData));
      }else {
        emit(GetHomeFailure(msg: _res.data['message']));
      }
    }catch(e){
      print(e);
      emit(GetHomeFailure(msg: BaseConstants.errorMessage));
    }
  }
}

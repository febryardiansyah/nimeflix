import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/models/schedule_model.dart';
import 'package:nimeflix/repositories/main_repo.dart';

part 'get_schedule_state.dart';

class GetScheduleCubit extends Cubit<GetScheduleState> {
  GetScheduleCubit() : super(GetScheduleInitial());
  final _repo = MainRepo();

  Future<void> fetchSchedule()async{
    emit(GetScheduleLoading());
    try{
      final _res = await _repo.getSchedule();
      if (_res.statusCode == 200) {
        final _data = List<ScheduleModel>.from(_res.data['scheduleList'].map((json)=>ScheduleModel.fromJson(json)));
        emit(GetScheduleSuccess(data: _data));
      } else {
        emit(GetScheduleFailure(msg: BaseConstants.errorMessage));
      }
    }catch(e){
      print(e);
      emit(GetScheduleFailure(msg: BaseConstants.errorMessage));
    }
  }
}

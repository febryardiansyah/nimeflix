part of 'get_schedule_cubit.dart';

abstract class GetScheduleState extends Equatable {
  const GetScheduleState();
  @override
  List<Object> get props => [];
}

class GetScheduleInitial extends GetScheduleState {}
class GetScheduleLoading extends GetScheduleState {}
class GetScheduleSuccess extends GetScheduleState {
  final List<ScheduleModel> data;

  GetScheduleSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetScheduleFailure extends GetScheduleState {
  final String msg;

  GetScheduleFailure({this.msg});
}

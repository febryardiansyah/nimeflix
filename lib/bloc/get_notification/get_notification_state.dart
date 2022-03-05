part of 'get_notification_cubit.dart';

abstract class GetNotificationState extends Equatable {
  const GetNotificationState();
  @override
  List<Object> get props => [];
}

class GetNotificationInitial extends GetNotificationState {}
class GetNotificationLoading extends GetNotificationState {}
class GetNotificationSuccess extends GetNotificationState {
  final MessagingModel data;

  GetNotificationSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetNotificationFailure extends GetNotificationState {}

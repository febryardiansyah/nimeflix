part of 'get_home_cubit.dart';

abstract class GetHomeState extends Equatable {
  const GetHomeState();
  @override
  List<Object> get props => [];
}

class GetHomeInitial extends GetHomeState {}
class GetHomeLoading extends GetHomeState {}
class GetHomeSuccess extends GetHomeState {
  final List<OngoingAnimeModel> ongoingData;
  final List<CompleteAnimeModel> completeData;

  GetHomeSuccess({this.ongoingData,this.completeData});
  @override
  List<Object> get props => [ongoingData,completeData];
}
class GetHomeFailure extends GetHomeState {
  final String msg;

  GetHomeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

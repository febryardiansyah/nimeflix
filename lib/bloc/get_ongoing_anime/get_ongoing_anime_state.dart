part of 'get_ongoing_anime_cubit.dart';

abstract class GetOngoingAnimeState extends Equatable {
  const GetOngoingAnimeState();
  @override
  List<Object> get props => [];
}

class GetOngoingAnimeInitial extends GetOngoingAnimeState {}
class GetOngoingAnimeLoading extends GetOngoingAnimeState {}
class GetOngoingAnimeSuccess extends GetOngoingAnimeState {
  final List<OngoingAnimeModel> data;

  GetOngoingAnimeSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetOngoingAnimeFailure extends GetOngoingAnimeState {
  final String msg;

  GetOngoingAnimeFailure({this.msg});
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

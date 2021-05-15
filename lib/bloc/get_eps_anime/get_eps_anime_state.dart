part of 'get_eps_anime_cubit.dart';

abstract class GetEpsAnimeState extends Equatable {
  const GetEpsAnimeState();
  @override
  List<Object> get props => [];
}

class GetEpsAnimeInitial extends GetEpsAnimeState {}
class GetEpsAnimeLoading extends GetEpsAnimeState {}
class GetEpsAnimeSuccess extends GetEpsAnimeState {
  final EpisodeModel data;

  GetEpsAnimeSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetEpsAnimeFailure extends GetEpsAnimeState {
  final String msg;

  GetEpsAnimeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

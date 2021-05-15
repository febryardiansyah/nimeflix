part of 'get_detail_anime_cubit.dart';

abstract class GetDetailAnimeState extends Equatable {
  const GetDetailAnimeState();
  @override
  List<Object> get props => [];
}

class GetDetailAnimeInitial extends GetDetailAnimeState {}
class GetDetailAnimeLoading extends GetDetailAnimeState {}
class GetDetailAnimeSuccess extends GetDetailAnimeState {
  final DetailAnimeModel data;

  GetDetailAnimeSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetDetailAnimeFailure extends GetDetailAnimeState {
  final String msg;

  GetDetailAnimeFailure({this.msg});
}

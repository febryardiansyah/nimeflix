part of 'get_batch_anime_cubit.dart';

abstract class GetBatchAnimeState extends Equatable {
  const GetBatchAnimeState();
  @override
  List<Object> get props => [];
}

class GetBatchAnimeInitial extends GetBatchAnimeState {}
class GetBatchAnimeLoading extends GetBatchAnimeState {}
class GetBatchAnimeSuccess extends GetBatchAnimeState {
  final BatchAnimeModel data;

  GetBatchAnimeSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetBatchAnimeFailure extends GetBatchAnimeState {
  final String msg;

  GetBatchAnimeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

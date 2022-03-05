part of 'get_mirror_stream_cubit.dart';

abstract class GetMirrorStreamState extends Equatable {
  const GetMirrorStreamState();
  @override
  List<Object> get props => [];
}

class GetMirrorStreamInitial extends GetMirrorStreamState {}
class GetMirrorStreamLoading extends GetMirrorStreamState {}
class GetMirrorStreamSuccess extends GetMirrorStreamState {
  final MirrorStreamModel data;

  GetMirrorStreamSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetMirrorStreamFailure extends GetMirrorStreamState {
  final String msg;

  GetMirrorStreamFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

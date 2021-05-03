part of 'get_genres_cubit.dart';

abstract class GetGenresState extends Equatable {
  const GetGenresState();
  @override
  List<Object> get props => [];
}

class GetGenresInitial extends GetGenresState {}
class GetGenresLoading extends GetGenresState {}
class GetGenresSuccess extends GetGenresState {
  final List<GenreModel> data;

  GetGenresSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class GetGenresFailure extends GetGenresState {
  final String msg;

  GetGenresFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

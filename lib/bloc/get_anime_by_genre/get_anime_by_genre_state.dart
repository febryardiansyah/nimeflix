part of 'get_anime_by_genre_cubit.dart';

abstract class GetAnimeByGenreState extends Equatable {
  const GetAnimeByGenreState();
  @override
  List<Object> get props => [];
}

class GetAnimeByGenreInitial extends GetAnimeByGenreState {}
class GetAnimeByGenreLoading extends GetAnimeByGenreState {}
class GetAnimeByGenreSuccess extends GetAnimeByGenreState {
  final List<AnimeByGenreModel> data;
  int page;

  GetAnimeByGenreSuccess({this.data, this.page});
  GetAnimeByGenreSuccess copyWith({List<AnimeByGenreModel> data,int page}){
    return GetAnimeByGenreSuccess(
      data: data ?? this.data,
      page: page ?? this.page
    );
  }
  @override
  List<Object> get props => [data,page];
}
class GetAnimeByGenreFailure extends GetAnimeByGenreState {
  final String msg;

  GetAnimeByGenreFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

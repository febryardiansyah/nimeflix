part of 'search_anime_cubit.dart';

abstract class SearchAnimeState extends Equatable {
  const SearchAnimeState();
  @override
  List<Object> get props => [];
}

class SearchAnimeInitial extends SearchAnimeState {}
class SearchAnimeLoading extends SearchAnimeState {}
class SearchAnimeSuccess extends SearchAnimeState {
  final List<SearchResultModel> data;

  SearchAnimeSuccess({this.data});
  @override
  List<Object> get props => [data];
}
class SearchAnimeFailure extends SearchAnimeState {
  final String msg;

  SearchAnimeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

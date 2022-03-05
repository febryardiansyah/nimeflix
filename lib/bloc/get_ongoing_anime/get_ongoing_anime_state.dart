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
  final bool hasReachedMax;
  int page;

  GetOngoingAnimeSuccess({this.data,this.page,this.hasReachedMax});
  GetOngoingAnimeSuccess copyWith({List<OngoingAnimeModel> data, int page,bool hasReachedMax}){
    return GetOngoingAnimeSuccess(
      page: page ?? this.page,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  @override
  List<Object> get props => [data,page];
}
class GetOngoingAnimeFailure extends GetOngoingAnimeState {
  final String msg;

  GetOngoingAnimeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

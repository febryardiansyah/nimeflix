part of 'get_complete_anime_cubit.dart';

abstract class GetCompleteAnimeState extends Equatable {
  const GetCompleteAnimeState();
  @override
  List<Object> get props => [];
}

class GetCompleteAnimeInitial extends GetCompleteAnimeState {}
class GetCompleteAnimeLoading extends GetCompleteAnimeState {}
class GetCompleteAnimeSuccess extends GetCompleteAnimeState {
  final List<CompleteAnimeModel> data;
  int page;

  GetCompleteAnimeSuccess({this.data,this.page});

  GetCompleteAnimeSuccess copyWith({List<CompleteAnimeModel> data,int page}){
    return GetCompleteAnimeSuccess(
      data: data ?? this.data,
      page: page ?? this.page
    );
  }
  @override
  List<Object> get props => [data];
}
class GetCompleteAnimeFailure extends GetCompleteAnimeState {
  final String msg;

  GetCompleteAnimeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

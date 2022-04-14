import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'latest_eps_state.dart';

class LatestEpsCubit extends Cubit<LatestEpsState> {
  LatestEpsCubit() : super(LatestEpsInitial());

  void init()=>emit(LatestEpsInitial());
  void update()=>emit(LatestEpsSuccess());
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimeflix/models/messaging_model.dart';
import 'package:nimeflix/repositories/messaging_repo.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  GetNotificationCubit() : super(GetNotificationInitial());
  final _repo = MessagingRepo();

  Future<void> fetchNotification()async{
    try{
      final _res = await _repo.getNotification();
      emit(GetNotificationSuccess(data: MessagingModel.fromJson(_res.data)));
    }catch(e){
      print(e);
      emit(GetNotificationFailure());
    }
  }
}

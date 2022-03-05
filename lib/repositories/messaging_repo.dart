import 'package:dio/dio.dart';
import 'package:nimeflix/services/base_service.dart';

class MessagingRepo extends BaseService{
  Future<Response> getNotification()async{
    final _res = await request(endpoint: 'notification',requestType: RequestType.GET);

    return _res;
  }
}
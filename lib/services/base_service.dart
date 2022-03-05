import 'package:dio/dio.dart';
import 'package:nimeflix/constants/BaseConstants.dart';

enum RequestType {GET,POST}

class BaseService{

  Future<Response> request({String endpoint,RequestType requestType = RequestType.GET,dynamic data})async{
    Dio _dio = Dio();
    Response _res;
    _dio.options.baseUrl = BaseConstants.baseUrl;
    try{
      switch(requestType){
        case RequestType.GET:
          _res = await _dio.get(endpoint);
          break;
        case RequestType.POST:
          _res = await _dio.post(endpoint,data: data);
          break;
        default:
          _res = await _dio.get(endpoint);
          break;
      }
    }on DioError catch(e){
      print(e);
    }
    return _res;
  }
}
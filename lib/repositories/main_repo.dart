import 'package:dio/dio.dart';
import 'package:nimeflix/services/base_service.dart';

class HomeRepo extends BaseService{

  Future<Response> getHome()async{
    final _res = await request(endpoint: 'home');
    print(_res.data);
    return _res;
  }

  Future<Response> getGenres()async{
    final _res = await request(endpoint: 'genres');
    return _res;
  }
}
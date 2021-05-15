import 'package:dio/dio.dart';
import 'package:nimeflix/services/base_service.dart';

class MainRepo extends BaseService{

  Future<Response> getHome()async{
    final _res = await request(endpoint: 'home');
    print(_res.data);
    return _res;
  }

  Future<Response> getGenres()async{
    final _res = await request(endpoint: 'genres');
    return _res;
  }

  Future<Response> searchAnime({String query})async{
    final _res = await request(endpoint: 'search/$query');
    print(_res.data);
    return _res;
  }

  Future<Response> getSchedule()async{
    final _res = await request(endpoint: 'schedule');
    print(_res.data);
    return _res;
  }

}
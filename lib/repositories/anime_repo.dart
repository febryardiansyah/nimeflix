import 'package:dio/dio.dart';
import 'package:nimeflix/services/base_service.dart';

class AnimeRepo extends BaseService{
  Future<Response> getDetailAnime({String id})async{
    final _res = await request(endpoint: 'anime/$id');
    print(_res.data);
    return _res;
  }

  Future<Response> getEpsAnime({String id})async{
    final _res = await request(endpoint: 'eps/$id');
    print(_res.data);
    return _res;
  }

  Future<Response> getBatchAnime({String id})async{
    final _res = await request(endpoint: 'batch/$id');
    print(_res.data);
    return _res;
  }

}
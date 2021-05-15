import 'package:flutter/material.dart';
import 'package:nimeflix/my_bottom_nav.dart';
import 'package:nimeflix/ui/detail/batch_anime_screen.dart';
import 'package:nimeflix/ui/detail/detail_anime_screen.dart';
import 'package:nimeflix/ui/detail/index_watch_anime.dart';
import 'package:nimeflix/ui/detail/watch_anime_screen.dart';


MaterialPageRoute _pageRoute ({RouteSettings settings, Widget body})=>MaterialPageRoute(
  settings: settings,
  builder: (_) => body,
);

Route generateRoute(RouteSettings settings){
  Route _route;
  final _args = settings.arguments;
  switch(settings.name){
    case rBottomNav:
      _route = _pageRoute(body: MyBottomNav(),settings: settings);
      break;
    case rDetailAnime:
      _route = _pageRoute(body: DetailAnimeScreen(id: _args,),settings: settings);
      break;
    case rWatchAnime:
      _route = _pageRoute(body: IndexWatchAnime(id: _args,),settings: settings);
      break;
    case rBatchAnime:
      _route = _pageRoute(body: BatchAnimeScreen(data: _args,),settings: settings);
      break;
  }
  return _route;
}

const String rBottomNav = '/';
const String rSplashScreen = '/splash';
const String rDetailAnime = '/detailAnime';
const String rWatchAnime = '/watchAnime';
const String rBatchAnime = '/batchAnime';
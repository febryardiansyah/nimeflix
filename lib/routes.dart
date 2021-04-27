import 'package:flutter/material.dart';
import 'package:nimeflix/my_bottom_nav.dart';
import 'package:nimeflix/ui/detail_anime_screen/detail_anime.dart';

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
      _route = _pageRoute(body: DetailAnime(),settings: settings);
      break;
  }
  return _route;
}

const String rBottomNav = '/';
const String rSplashScreen = '/splash';
const String rDetailAnime = '/detailAnime';
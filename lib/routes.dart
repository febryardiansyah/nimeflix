import 'package:flutter/material.dart';
import 'package:nimeflix/my_bottom_nav.dart';
import 'package:nimeflix/ui/detail/alternate_stream_screen.dart';
import 'package:nimeflix/ui/detail/batch_anime_screen.dart';
import 'package:nimeflix/ui/detail/detail_anime_screen.dart';
import 'package:nimeflix/ui/detail/index_watch_anime.dart';
import 'package:nimeflix/ui/detail/mirror_stream_screen.dart';
import 'package:nimeflix/ui/detail/watch_anime_screen.dart';
import 'package:nimeflix/ui/detail/watch_full_screen.dart';
import 'package:nimeflix/ui/more/anime_by_genre_screen.dart';
import 'package:nimeflix/ui/more/more_complete_anime_screen.dart';
import 'package:nimeflix/ui/more/more_history_anime.dart';
import 'package:nimeflix/ui/more/more_ongoing_anime_screen.dart';
import 'package:nimeflix/ui/more/more_screen_children/about_app_screen.dart';
import 'package:nimeflix/ui/more/more_screen_children/history_screen.dart';
import 'package:nimeflix/ui/more/more_screen_children/privacy_policy_screen.dart';
import 'package:nimeflix/ui/more/more_screen_children/tos_screen.dart';
import 'package:nimeflix/ui/schedule/schedule_screen.dart';
import 'package:nimeflix/ui/search/search_result_screen.dart';
import 'package:nimeflix/ui/search/search_screen.dart';


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
      _route = _pageRoute(body: IndexWatchAnime(data: _args,),settings: settings);
      break;
    case rBatchAnime:
      _route = _pageRoute(body: BatchAnimeScreen(data: _args,),settings: settings);
      break;
    case rSchedule:
      _route = _pageRoute(body: ScheduleScreen(),settings: settings);
      break;
    case rMoreCompleteAnime:
      _route = _pageRoute(body: MoreCompleteAnimeScreen(),settings: settings);
      break;
    case rMoreOngoingAnime:
      _route = _pageRoute(body: MoreOngoingAnimeScreen(),settings: settings);
      break;
    case rAnimeByGenre:
      _route = _pageRoute(body: AnimeByGenreScreen(id: _args,),settings: settings);
      break;
    case rPrivacyPolicy:
      _route = _pageRoute(body: PrivacyPolicyScreen(),settings: settings);
      break;
    case rTOS:
      _route = _pageRoute(body: TosScreen(),settings: settings);
      break;
    case rAboutApp:
      _route = _pageRoute(body: AboutAppScreen(),settings: settings);
      break;
    case rMirrorStreaming:
      _route = _pageRoute(body: MirrorStreamScreen(data: _args,),settings: settings);
      break;
    case rSearch:
      _route = _pageRoute(body: SearchScreen(),settings: settings);
      break;
    case rSearchResult:
      _route = _pageRoute(body: SearchResultScreen(query: _args,),settings: settings);
      break;
    case rHistoryAnime:
      _route = _pageRoute(body: MoreHistoryAnimeScreen(),settings: settings);
      break;
    case rAlternateStream:
      _route = _pageRoute(body: AlternateStreamScreen(id: _args),settings: settings);
      break;
    case rWatchFullscreen:
      _route = _pageRoute(body: WatchFullScreen(url: _args),settings: settings);
      break;
  }
  return _route;
}

const String rBottomNav = '/';
const String rSplashScreen = '/splash';
const String rDetailAnime = '/detailAnime';
const String rWatchAnime = '/watchAnime';
const String rBatchAnime = '/batchAnime';
const String rSchedule = '/schedule';
const String rMoreCompleteAnime = '/moreCompleteAnime';
const String rMoreOngoingAnime = '/moreOngoingAnime';
const String rAnimeByGenre = '/animeByGenre';
const String rPrivacyPolicy = '/privacyPolicy';
const String rTOS = '/tos';
const String rAboutApp = '/aboutApp';
const String rMirrorStreaming = '/mirrorStreaming';
const String rSearch = '/search';
const String rSearchResult = '/searchResult';
const String rHistoryAnime = '/historyAnime';
const String rAlternateStream = '/alternateStream';
const String rWatchFullscreen = '/watchFullscreen';
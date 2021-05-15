import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/ui/home_screen/complete_anime.dart';
import 'package:nimeflix/ui/home_screen/genre_list.dart';
import 'package:nimeflix/ui/home_screen/my_carousel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/ui/home_screen/ongoing_anime.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh()async{
    context.read<GetHomeCubit>().fetchHome();
    context.read<GetGenresCubit>().fetchGenres();
    _refreshController.refreshCompleted();
  }
  @override
  void initState() {
    super.initState();
    context.read<GetHomeCubit>().fetchHome();
    context.read<GetGenresCubit>().fetchGenres();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh,
        header: ClassicHeader(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              backgroundColor: Colors.transparent,
              expandedHeight: 70,
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: (){
                    context.read<GetHomeCubit>().fetchHome();
                    context.read<GetGenresCubit>().fetchGenres();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: ()=>Navigator.pushNamed(context, rSchedule),
                  ),
                ),
              ],
              title: Container(
                width: 94,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(BaseConstants.logoAsset,),
                    fit: BoxFit.contain
                  )
                ),
              )
            ),
            SliverToBoxAdapter(
              child: MyCarousel(),
            ),
            SliverToBoxAdapter(
              child: CompleteAnime(),
            ),
            SliverToBoxAdapter(
              child: OngoingAnime(),
            ),
            SliverToBoxAdapter(
              child: GenreList()
            )
            // GenreList(),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/ui/home_screen/complete_anime.dart';
import 'package:nimeflix/ui/home_screen/genre_list.dart';
import 'package:nimeflix/ui/home_screen/my_carousel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            backgroundColor: Colors.transparent,
            expandedHeight: 70,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(FontAwesomeIcons.download),
              )
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
            child: GenreList()
          )
          // GenreList(),
        ],
      ),
    );
  }
}
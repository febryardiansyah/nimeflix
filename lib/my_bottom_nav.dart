import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/ui/home_screen/home_screen.dart';
import 'package:nimeflix/ui/more/more_screen.dart';
import 'package:nimeflix/ui/schedule/schedule_screen.dart';
import 'package:nimeflix/ui/search/search_screen.dart';
import 'package:nimeflix/ui/watch_later/watch_later_screen.dart';

class MyBottomNav extends StatefulWidget {
  MyBottomNav({Key key}) : super(key: key);

  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;
  List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    WatchLaterScreen(),
    MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        // selectedItemColor: Colors.blue,
        onItemSelected: (val){
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Bookmarks')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.more_vert),
            title: Text('More')
          ),
        ],
      ),
    );
  }
}
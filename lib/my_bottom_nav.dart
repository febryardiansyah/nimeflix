import 'package:flutter/material.dart';
import 'package:nimeflix/ui/home_screen/home_screen.dart';

class MyBottomNav extends StatefulWidget {
  MyBottomNav({Key key}) : super(key: key);

  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;
  List<Widget> _children = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (val){
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Bookmarks')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text('Bookmarks')
          ),
        ],
      ),
    );
  }
}
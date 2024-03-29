// import 'package:admob_flutter/admob_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/ui/home_screen/home_screen.dart';
import 'package:nimeflix/ui/more/more_screen.dart';
import 'package:nimeflix/ui/schedule/schedule_screen.dart';
import 'package:nimeflix/ui/search/search_screen.dart';
import 'package:nimeflix/ui/watch_later/watch_later_screen.dart';
import 'package:nimeflix/utils/helpers.dart';

class MyBottomNav extends StatefulWidget {
  MyBottomNav({Key key}) : super(key: key);

  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;
  List<int> pages = [0,];
  // AdmobInterstitial _interstitialAd;

  // @override
  // void initState() {
  //   super.initState();
  //   _interstitialAd = AdmobInterstitial(
  //       adUnitId: BaseConstants.interstitialAddId,
  //       listener: (event,args){
  //         print('INTERSTITIAL EVENT ==> $event');
  //         if (event == AdmobAdEvent.closed){
  //           _interstitialAd.load();
  //         }
  //       }
  //   );
  //   _interstitialAd.load();
  // }
  @override
  void dispose() {
    // _interstitialAd.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      HomeScreen(),
      pages.contains(1)?ScheduleScreen():Container(),
      pages.contains(2)?WatchLaterScreen():Container(),
      pages.contains(3)?MoreScreen():Container(),
    ];
    return Scaffold(
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (val)async{
          if (val == 2) {
            // if (await _interstitialAd.isLoaded) {
            //   _interstitialAd.show();
            // } else{
            //   print('rewardedAd not show');
            // }
          }
          List _pages = pages;
          setState(() {
            if (!_pages.contains(val)) {
              _pages.add(val);
            }
            pages = _pages;
            _currentIndex = val;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.date_range),
            title: Text('Jadwal')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Tersimpan')
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.more_vert),
            title: Text('Lainnya')
          ),
        ],
      ),
    );
  }
}
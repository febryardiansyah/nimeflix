import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/bloc/get_notification/get_notification_cubit.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/services/notification_service.dart';
import 'package:nimeflix/ui/home_screen/complete_anime.dart';
import 'package:nimeflix/ui/home_screen/genre_list.dart';
import 'package:nimeflix/ui/home_screen/my_carousel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/ui/home_screen/ongoing_anime.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static const channel_id = '123';
  
  void _onRefresh()async{
    context.read<GetHomeCubit>().fetchHome();
    context.read<GetGenresCubit>().fetchGenres();
    _refreshController.refreshCompleted();
  }
  @override
  void initState() {
    super.initState();
    _notifInit().then((value) => showNotification())
    .catchError((err)=>print(err));
    context.read<GetHomeCubit>().fetchHome();
    context.read<GetGenresCubit>().fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GetNotificationCubit,GetNotificationState>(
        listener: (context,state){
          if (state is GetNotificationSuccess) {
            final _data = state.data;
            if (_data.version != BaseConstants.appVersion) {
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: Text(_data.title),
                content: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text('Versi : ${_data.version}'),
                    Divider(),
                    Text('Apa yang baru?'),
                    Wrap(
                      direction: Axis.vertical,
                      children: _data.logs.map((e) => Text('- $e')).toList(),
                    )
                  ],
                ),
                actions: [
                  FlatButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('Nanti saja',style: TextStyle(color: Colors.red),),
                  ),
                  FlatButton(
                    onPressed: ()async{
                      await launch(_data.link);
                    },
                    child: Text('Update',style: TextStyle(color: Colors.lightBlue),),
                  ),
                ],
              ));
            }
          }
        },
        child: SmartRefresher(
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
                  // IconButton(
                  //   icon: Icon(Icons.refresh),
                  //   onPressed: (){
                  //     context.read<GetHomeCubit>().fetchHome();
                  //     context.read<GetGenresCubit>().fetchGenres();
                  //   },
                  // ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      // onPressed: (){
                      //   NotificationService().showNotification();
                      // },
                      onPressed: ()=>Navigator.pushNamed(context, rSearch),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _notifInit()async{
    final AndroidInitializationSettings _initAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings _initSetting = InitializationSettings(android: _initAndroid,iOS: null);

    await _plugin.initialize(_initSetting,onSelectNotification: selectNotification);

    tz.initializeTimeZones();
  }

  Future selectNotification(String payload)async{
    Navigator.pushNamed(context, payload);
  }

  tz.TZDateTime _nextSchedule(){
    tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime _schedule = tz.TZDateTime(tz.local,_now.year,_now.month,_now.day,10);

    if (_schedule.isBefore(_now)) {
      _schedule = _schedule.add(Duration(days: 1));
    }
    return _schedule;
  }

  void showNotification()async{
    await _plugin.zonedSchedule(
        1,'Sudah nonton anime hari ini?', 'Berikut anime yang harus kamu tonton season ini',_nextSchedule(),
        NotificationDetails(android: AndroidNotificationDetails(channel_id,'Nimeflix','To remind you about watching anime',)),
        androidAllowWhileIdle: true,uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: rMoreOngoingAnime,matchDateTimeComponents: DateTimeComponents.time
    );
  }
}
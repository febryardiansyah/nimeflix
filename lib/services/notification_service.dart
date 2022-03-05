import 'package:flutter/cupertino.dart';
import 'package:nimeflix/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService()=> _notificationService;

  NotificationService._internal();

  static const channel_id = '123';

  Future<void> init()async{
    final AndroidInitializationSettings _initAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings _initSetting = InitializationSettings(android: _initAndroid,iOS: null);

    await _plugin.initialize(_initSetting,onSelectNotification: selectNotification);

    tz.initializeTimeZones();
  }

  Future selectNotification(String payload)async{
    print(payload);

  }

  tz.TZDateTime _nextSchedule(){
    tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime _schedule = tz.TZDateTime(tz.local,_now.year,_now.month,_now.day,8);

    if (_schedule.isBefore(_now)) {
      _schedule = _schedule.add(Duration(days: 1));
    }
    return _schedule;
  }

  void showNotification()async{
    await _plugin.cancel(1);
    // await _plugin.zonedSchedule(
    //   1,'Sudah nonton anime hari ini?', 'Berikut anime yang harus kamu tonton season ini',_nextSchedule(),
    //   NotificationDetails(android: AndroidNotificationDetails(channel_id,'Nimeflix','To remind you about watching anime')),
    //   androidAllowWhileIdle: true,uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    //   payload: rMoreOngoingAnime,matchDateTimeComponents: DateTimeComponents.time
    // );
  }

}
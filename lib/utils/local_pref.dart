import 'package:shared_preferences/shared_preferences.dart';

class LocalPref {
  static Future<void> setReminderNotif() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('reminder_notif', true);
  }

  static Future<bool> getReminderNotif() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool('reminder_notif');
  }
}

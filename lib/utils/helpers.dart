import 'package:flutter/cupertino.dart';
import 'package:nimeflix/constants/BaseConstants.dart';

class Helpers {
  static void requestNode(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
  static void showInterstitialAdd(){
    // FacebookInterstitialAd.loadInterstitialAd(
    //   placementId: BaseConstants.interstitialAddId,
    //   listener: (result, value) {
    //     print('InterstitialAdd Result : $result');
    //     print('InterstitialAdd Value : $value');
    //     if (result == InterstitialAdResult.LOADED){
    //       FacebookInterstitialAd.showInterstitialAd(delay: 5000);
    //     }
    //
    //   },
    // );
  }
}
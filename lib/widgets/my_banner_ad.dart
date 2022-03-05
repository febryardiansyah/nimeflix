// import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/constants/BaseConstants.dart';

class MyBannerAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Container(
    //   alignment: Alignment(0.5, 1),
    //   child: FacebookBannerAd(
    //     placementId: BaseConstants.bannerAddId,
    //     bannerSize: BannerSize.STANDARD,
    //     listener: (result, value) {
    //       switch (result) {
    //         case BannerAdResult.ERROR:
    //           print("Error: $value");
    //           break;
    //         case BannerAdResult.LOADED:
    //           print("Loaded: $value");
    //           break;
    //         case BannerAdResult.CLICKED:
    //           print("Clicked: $value");
    //           break;
    //         case BannerAdResult.LOGGING_IMPRESSION:
    //           print("Logging Impression: $value");
    //           break;
    //       }
    //     },
    //   ),
    // );
  }
}

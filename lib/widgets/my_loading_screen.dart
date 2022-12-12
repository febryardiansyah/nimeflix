import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [
            Colors.white,
          ],
        ),
        Text('Tunggu sebentar...')
      ],
    );
  }
}

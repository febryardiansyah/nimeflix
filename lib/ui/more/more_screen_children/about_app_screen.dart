import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About this app'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text('''Nimeflix is an android app to streaming and download anime. This app provides some anime with indonesian subtitle.'''),
        ),
      ),
    );
  }
}

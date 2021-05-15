import 'package:flutter/material.dart';

class WatchLaterScreen extends StatefulWidget {
  WatchLaterScreen({Key key}) : super(key: key);

  @override
  _WatchLaterScreenState createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tonton nanti'),
      ),
    );
  }
}
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AlternateStreamScreen extends StatefulWidget {
  final String id;

  const AlternateStreamScreen({Key key, this.id}) : super(key: key);

  @override
  _AlternateStreamScreenState createState() => _AlternateStreamScreenState();
}

class _AlternateStreamScreenState extends State<AlternateStreamScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alternatif Streaming'),
        actions: [
          TextButton(
            child: Text('Buka di Browser'),
            onPressed: ()async{
              await launch(widget.id);
            },
          )
        ],
      ),
      body: Builder(
        builder: (context)=>WebView(
          userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.id,
          onWebViewCreated: (WebViewController webViewCtrl) {
            _controller.complete(webViewCtrl);
          },
        ),
      ),
    );
  }
}

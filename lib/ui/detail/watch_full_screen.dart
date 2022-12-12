import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchFullScreen extends StatefulWidget {
  final String url;
  const WatchFullScreen({Key key, this.url}) : super(key: key);

  @override
  State<WatchFullScreen> createState() => _WatchFullScreenState();
}

class _WatchFullScreenState extends State<WatchFullScreen> {
  double progress = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return Future.value(true);
      },
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.url),
          ),
          androidOnPermissionRequest: (
            controller,
            origin,
            resources,
          ) async {
            return PermissionRequestResponse(
              action: PermissionRequestResponseAction.GRANT,
              resources: resources,
            );
          },
          onProgressChanged: (controller, progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      ),
    );
  }
}

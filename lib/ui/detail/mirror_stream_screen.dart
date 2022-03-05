import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_mirror_stream/get_mirror_stream_cubit.dart';
import 'package:nimeflix/models/episode_model.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MirrorStreamScreen extends StatefulWidget {
  final MirrorList data;

  const MirrorStreamScreen({Key key, this.data}) : super(key: key);

  @override
  _MirrorStreamScreenState createState() => _MirrorStreamScreenState();
}

class _MirrorStreamScreenState extends State<MirrorStreamScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    Wakelock.enabled;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    context.read<GetMirrorStreamCubit>().fetchMirrorStream(mirrorId: widget.data.id,animeId: widget.data.host);
  }
  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetMirrorStreamCubit,GetMirrorStreamState>(
        builder: (context,state){
          if (state is GetMirrorStreamLoading) {
            return MyLoadingScreen();
          }
          if (state is GetMirrorStreamFailure) {
            return ReconnectButton(onReconnect: ()=>context.read<GetMirrorStreamCubit>().fetchMirrorStream(mirrorId: widget.data.id,animeId: widget.data.host),msg: state.msg,);
          }
          if (state is GetMirrorStreamSuccess) {
            final _data = state.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(_data.title),
                elevation: 0,
                actions: [
                  IconButton(onPressed: ()async{
                    await launch(_data.streamLink);
                  }, icon: Icon(Icons.open_in_browser_outlined))
                ],
              ),
              body: Builder(
                builder: (context)=>WebView(
                  userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _data.streamLink,
                  onWebViewCreated: (WebViewController webViewCtrl) {
                    _controller.complete(webViewCtrl);
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
import 'package:better_player/better_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeScreen extends StatefulWidget {
  WatchAnimeScreen({Key key}) : super(key: key);

  @override
  _WatchAnimeScreenState createState() => _WatchAnimeScreenState();
}

class _WatchAnimeScreenState extends State<WatchAnimeScreen> {
  final String _url = 'https://r5---sn-2uuxa3vh-wvbe.googlevideo.com/videoplayback?expire=1619622899&ei=cwuJYO_AMIGIuALOzYbwDQ&ip=2a04:3543:1000:2310:30da:13ff:fead:6be6&id=ce711b8342e4bc6a&itag=18&source=blogger&susc=bl&mime=video/mp4&vprv=1&dur=1430.233&lmt=1619485849097494&txp=1311224&sparams=expire,ei,ip,id,itag,source,susc,mime,vprv,dur,lmt&sig=AOq0QJ8wRAIgOdXnbeqFBtiJt8vF7t_tzWzqWxHdM7m0WCTEmynUUxwCIHoQ681dcMb3t95vVYqg5STvowVxAAeIR8yKiQzriDtU&redirect_counter=1&rm=sn-25gkz76&req_id=a766fae7012da3ee&cms_redirect=yes&ipbypass=yes&mh=xq&mip=36.73.32.68&mm=31&mn=sn-2uuxa3vh-wvbe&ms=au&mt=1619593984&mv=m&mvi=5&pl=22&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIgSwSD94CvNWQUbjXYlTvOxt02KwhaM0jUj-zoCBL8K3cCIQDineX0XTv8xLm9LWmPh0X4YjXint8TD9UMFH420BGAQw%3D%3D';
  FlickManager _flickManager;
  Duration _duration;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(videoPlayerController: VideoPlayerController.network(_url),autoPlay: true);

    _flickManager.flickVideoManager.addListener(() {
      setState(() {
        _duration = _flickManager.flickVideoManager.videoPlayerValue.position;
        print(_duration.toString().split(':').join('').split('.')[0]);
      });
    });
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: FlickVideoPlayer(
                flickManager: _flickManager,
              ),
            ),
            Text('${_duration}'),
            FlatButton(
              child: Text('pause'),
              onPressed: (){
                _flickManager.flickVideoManager.videoPlayerController.seekTo(Duration(minutes: 0011));
              },
            )
          ],
        ),
      ),
    );
  }
}
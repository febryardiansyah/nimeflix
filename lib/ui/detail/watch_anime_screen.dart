import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nimeflix/bloc/latest_eps/latest_eps_cubit.dart';
import 'package:nimeflix/models/episode_model.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/ui/detail/index_watch_anime.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import '../../constants/BaseConstants.dart';
import '../../utils/hive_database/latest_episode_model.dart';

class WatchAnimeScreen extends StatefulWidget {
  final EpisodeModel data;
  final String animeId;

  const WatchAnimeScreen({Key key, this.data,this.animeId}) : super(key: key);

  @override
  _WatchAnimeScreenState createState() => _WatchAnimeScreenState();
}

class _WatchAnimeScreenState extends State<WatchAnimeScreen> {

  final ChromeSafariBrowser browser = new MyChromeSafariBrowser();

  final _latestEpisodeBox = Hive.box(BaseConstants.hLatestEpisode);
  AdmobInterstitial _interstitialAd;

  @override
  void initState() {
    super.initState();
    _interstitialAd = AdmobInterstitial(
        adUnitId: BaseConstants.interstitialAddId,
        listener: (event,args){
          print('INTERSTITIAL EVENT ==> $event');
          if (event == AdmobAdEvent.closed){
            _interstitialAd.load();
          }
        }
    );
    _interstitialAd?.load();
  }
  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data.title ?? ''),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse('${widget.data.alternateStream}')
                  ),
                  androidOnPermissionRequest: (controller,origin,resources)async{
                    return PermissionRequestResponse(
                      action: PermissionRequestResponseAction.GRANT,
                      resources: resources
                    );
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text('Eps.Sebelumnya'),
                      color: widget.data.prev.isEmpty?Colors.grey:Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed:widget.data.prev.isEmpty?null: ()async{
                        final _res = LatestEpisodeModel(
                          animeEndpoint: widget.animeId,
                          episodeEndpoint: widget.data.prev,
                          episodeTitle: widget.data.title,
                          lastEpisode: 0,
                        );
                        _latestEpisodeBox.add(_res);
                        context.read<LatestEpsCubit>().update();
                        if (await _interstitialAd.isLoaded) {
                          _interstitialAd.show();
                        } else {
                          print('ads wont loaded');
                        }
                        Navigator.popAndPushNamed(context, rWatchAnime,arguments: WatchAnimeParams(
                          epsId: widget.data.prev,animeId: widget.animeId,
                        ));
                      },
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text('Eps.Berikutnya'),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed: widget.data.next.isEmpty?null: ()async{
                        final _res = LatestEpisodeModel(
                            animeEndpoint: widget.animeId,
                            episodeEndpoint: widget.data.next,
                            episodeTitle: widget.data.title,
                            lastEpisode: 0,
                        );
                        _latestEpisodeBox.add(_res);
                        context.read<LatestEpsCubit>().update();
                        if (await _interstitialAd.isLoaded) {
                          _interstitialAd.show();
                        } else {
                          print('ads wont loaded');
                        }
                        Navigator.popAndPushNamed(context, rWatchAnime,arguments: WatchAnimeParams(
                          epsId: widget.data.next,animeId: widget.animeId,
                        ));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(widget.data.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Note : Silahkan klik ikon play dua kali untuk memulai video',style: TextStyle(color: Colors.amber,)),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.amber)
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jika video diatas tidak dapat diputar, silakan buka video melalui browser. Klik tombol dibawah untuk membukanya',
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                    SizedBox(height: 8),
                    FlatButton(
                      child: Text('Buka video di Browser'),
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      onPressed: () async {
                        launch('${widget.data.alternateStream}');
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Download episode ini'),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,color: Colors.orange)
                      ),
                      child: ExpansionTile(
                        title: Text(widget.data.quality.lowQuality.quality),
                        subtitle: Text(widget.data.quality.lowQuality.size),
                        children: widget.data.quality.lowQuality.downloadLinks.map((e) => ListTile(
                          title: Text(e.host),
                          trailing: Icon(Icons.file_download),
                          onTap: ()async{
                            await launch(e.link);
                          },
                        )).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: Colors.orange)
                      ),
                      child: ExpansionTile(
                        title: Text(widget.data.quality.mediumQuality.quality),
                        subtitle: Text(widget.data.quality.mediumQuality.size),
                        children: widget.data.quality.mediumQuality.downloadLinks.map((e) => ListTile(
                          title: Text(e.host),
                          trailing: Icon(Icons.file_download),
                          onTap: ()async{
                            await launch(e.link);
                          },
                        )).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: Colors.orange)
                      ),
                      child: ExpansionTile(
                        title: Text(widget.data.quality.highQuality.quality),
                        subtitle: Text(widget.data.quality.highQuality.size),
                        children: widget.data.quality.highQuality.downloadLinks.map((e) => ListTile(
                          title: Text(e.host),
                          trailing: Icon(Icons.file_download),
                          onTap: ()async{
                            await launch(e.link);
                          },
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

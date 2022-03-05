import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/models/episode_model.dart';
import 'package:nimeflix/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchAnimeScreen extends StatefulWidget {
  final EpisodeModel data;

  const WatchAnimeScreen({Key key, this.data}) : super(key: key);

  @override
  _WatchAnimeScreenState createState() => _WatchAnimeScreenState();
}

class _WatchAnimeScreenState extends State<WatchAnimeScreen> {
  Size _size;
  // final _durationBox = Hive.box(BaseConstants.hLatestDurationWatched);
  String _currentDuration = '0:00:0.000000';

  BetterPlayerController _betterPlayerController;
  BetterPlayerDataSource _betterPlayerDataSource;

  // Future<void> _checkLastDuration()async{
  //   for(int i = 0;i<_durationBox.length;i++){
  //     LatestDurationWatchedModel _data = _durationBox.get(i);
  //     if (_data.endpoint == widget.data.id) {
  //       print('Duration from DB ${_data.duration}');
  //       setState(() {
  //         _currentDuration = _data.duration;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _checkLastDuration();
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16/9,fit: BoxFit.contain,autoPlay: false,allowedScreenSleep: false,
    //   eventListener: (BetterPlayerEvent event)async{
    //   if(event.betterPlayerEventType == BetterPlayerEventType.progress){
    //     print('Duration : ${event.parameters['progress'] as Duration}');
    //     final _data = LatestDurationWatchedModel(
    //         endpoint: widget.data.id,duration: event.parameters['progress'].toString()
    //     );
    //     _durationBox.add(_data);
    //   }
    // },
      errorBuilder: (context,err)=>Center(child: Text('Video tidak dapat dimainkan, silahkan coba alternatif dibawah',textAlign: TextAlign.center,)),
      // startAt: Helpers.parseDuration(_currentDuration),
    );
    _betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.data.linkStream,);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
  }
  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BetterPlayerMultipleGestureDetector(
                onTap: (){

                },
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: BetterPlayer(controller: _betterPlayerController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('Back'),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: (){
                    Navigator.pop(context);
                  },
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
                    child: Text('Note : Jika streaming diatas tidak bisa, silahkan ganti streaming atau download episode ini dibawah',style: TextStyle(color: Colors.red),),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.red)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih kualitas video lainnya'),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: ExpansionTile(
                        leading: Icon(Icons.tv_rounded),
                        title: Text(widget.data.mirror1.quality),
                        children: widget.data.mirror1.mirrorList.map((e){
                          return ListTile(
                            leading: Text((widget.data.mirror1.mirrorList.indexOf(e)+1).toString()),
                            title: Text(e.host),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: ()async{
                              Navigator.pushNamed(context, rMirrorStreaming,arguments: MirrorList(id: e.id,host: widget.data.id));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: ExpansionTile(
                        leading: Icon(Icons.tv_rounded),
                        title: Text(widget.data.mirror2.quality),
                        children: widget.data.mirror2.mirrorList.map((e){
                          return ListTile(
                            leading: Text((widget.data.mirror2.mirrorList.indexOf(e)+1).toString()),
                            title: Text(e.host),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: (){
                              Navigator.pushNamed(context, rMirrorStreaming,arguments: MirrorList(id: e.id,host: widget.data.id));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: ExpansionTile(
                        leading: Icon(Icons.tv_rounded),
                        title: Text(widget.data.mirror3.quality),
                        children: widget.data.mirror3.mirrorList.map((e){
                          return ListTile(
                            leading: Text((widget.data.mirror3.mirrorList.indexOf(e)+1).toString()),
                            title: Text(e.host),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: (){
                              Navigator.pushNamed(context, rMirrorStreaming,arguments: MirrorList(id: e.id,host: widget.data.id));
                            },
                          );
                        }).toList(),
                      ),
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
import 'package:better_player/better_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/models/episode_model.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeScreen extends StatefulWidget {
  final EpisodeModel data;

  const WatchAnimeScreen({Key key, this.data}) : super(key: key);

  @override
  _WatchAnimeScreenState createState() => _WatchAnimeScreenState();
}

class _WatchAnimeScreenState extends State<WatchAnimeScreen> {
  FlickManager _flickManager;
  Size _size;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(videoPlayerController: VideoPlayerController.network(widget.data.linkStream),autoPlay: true);
  }

  @override
  void dispose() {
    _flickManager.dispose();
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
              AspectRatio(
                aspectRatio: 16/9,
                child: FlickVideoPlayer(
                  flickManager: _flickManager,
                ),
              ),
              FlatButton(
                child: Text('Back'),
                color: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              Center(child: Text(widget.data.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Download'),
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
                          onTap: (){},
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
                          onTap: (){},
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
                          onTap: (){},
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
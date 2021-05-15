import 'package:flutter/material.dart';
import 'package:nimeflix/bloc/get_batch_anime/get_batch_anime_cubit.dart';
import 'package:nimeflix/models/detail_anime_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BatchAnimeScreen extends StatefulWidget {
  final DetailAnimeModel data;

  const BatchAnimeScreen({Key key, this.data}) : super(key: key);
  @override
  _BatchAnimeScreenState createState() => _BatchAnimeScreenState();
}

class _BatchAnimeScreenState extends State<BatchAnimeScreen> {
  Size _size;
  @override
  void initState() {
    super.initState();
    context.read<GetBatchAnimeCubit>().fetchBatchAnime(id: widget.data.batchLink.id);
  }
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: _size.width,
                  height: _size.height * 0.4,
                ),
                Container(
                  width: _size.width,
                  height: _size.height * 0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.data.thumb),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: _size.height * 0.15),
                    width: 100,
                    height: 140,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.data.thumb),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<GetBatchAnimeCubit,GetBatchAnimeState>(
              builder: (context,state){
                if (state is GetBatchAnimeLoading) {
                  return MyLoadingScreen();
                }
                if (state is GetBatchAnimeFailure) {
                  return ReconnectButton(msg: state.msg,onReconnect: ()=>context.read<GetBatchAnimeCubit>().fetchBatchAnime(id: widget.data.batchLink.id),);
                }
                if (state is GetBatchAnimeSuccess) {
                  final _data = state.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(_data.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text('Download'),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: Colors.orange)
                          ),
                          child: ExpansionTile(
                            title: Text(_data.downloadList.lowQuality.quality),
                            subtitle: Text(_data.downloadList.lowQuality.size),
                            children: _data.downloadList.lowQuality.downloadLinks.map((e) => ListTile(
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
                            title: Text(_data.downloadList.mediumQuality.quality),
                            subtitle: Text(_data.downloadList.mediumQuality.size),
                            children: _data.downloadList.mediumQuality.downloadLinks.map((e) => ListTile(
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
                            title: Text(_data.downloadList.highQuality.quality),
                            subtitle: Text(_data.downloadList.highQuality.size),
                            children: _data.downloadList.highQuality.downloadLinks.map((e) => ListTile(
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
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
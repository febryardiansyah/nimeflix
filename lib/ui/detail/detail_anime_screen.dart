import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nimeflix/bloc/get_detail_anime/get_detail_anime_cubit.dart';
import 'package:nimeflix/bloc/latest_eps/latest_eps_cubit.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/ui/detail/index_watch_anime.dart';
import 'package:nimeflix/utils/hive_database/history_anime_model.dart';
import 'package:nimeflix/utils/hive_database/latest_episode_model.dart';
import 'package:nimeflix/utils/hive_database/save_for_later_model.dart';
import 'package:nimeflix/widgets/my_banner_ad.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:toast/toast.dart';

class DetailAnimeScreen extends StatefulWidget {
  final String id;

  const DetailAnimeScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailAnimeScreenState createState() => _DetailAnimeScreenState();
}

class _DetailAnimeScreenState extends State<DetailAnimeScreen> {
  Size _size;
  bool _isEpsReversed = false;

  final _saveForLaterBox = Hive.box(BaseConstants.hSaveForLater);
  bool _isAnimeSaved = false;
  SaveForLaterModel _saveForLaterModel;
  String _animeEndpoint = '';

  final _historyAnimeBox = Hive.box(BaseConstants.hHistoryAnime);
  bool _isAnimeSeen = false;

  final _latestEpisodeBox = Hive.box(BaseConstants.hLatestEpisode);
  String _episode = '';
  int _idxLastEps = 0;

  String _epsId = '';

  AdmobInterstitial _interstitialAd;
  AdmobBannerSize _bannerSize;

  void _checkIsSaved(){
    setState(() {
      _animeEndpoint = widget.id;
    });
    for(int i = 0;i<_saveForLaterBox.length;i++){
      _saveForLaterModel = _saveForLaterBox.getAt(i);
      if (_saveForLaterModel.endpoint == widget.id) {
        setState(() {
          _isAnimeSaved = true;
        });
        break;
      }
      else{
        setState(() {
          _isAnimeSaved = false;
        });
      }
    }

    for(int i = 0;i<_historyAnimeBox.length;i++){
      HistoryAnimeModel _item = _historyAnimeBox.getAt(i);
      print('from db ${_item.endpoint}');
      print('from API ${widget.id}');
      if (_item.endpoint == widget.id) {
        setState(() {
          _isAnimeSeen = true;
        });
        _historyAnimeBox.deleteAt(i);
      }
    }
  }
  void _checkLatestEpisode(){
    for(int i=0;i<_latestEpisodeBox.length;i++){
      LatestEpisodeModel _data = _latestEpisodeBox.getAt(i);
      print(widget.id);
      print(_data.animeEndpoint);
      if (_data.animeEndpoint == widget.id) {
        setState(() {
          // _idxLastEps = _data.lastEpisode;
          _episode = _data.episodeTitle;
          _epsId = _data.episodeEndpoint;
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    context.read<GetDetailAnimeCubit>().fetchDetailAnime(id: widget.id);
    _checkIsSaved();
    _checkLatestEpisode();
    _bannerSize = AdmobBannerSize.BANNER;
    _interstitialAd = AdmobInterstitial(
        adUnitId: BaseConstants.interstitialAddId,
        listener: (event,args){
          print('INTERSTITIAL EVENT ==> $event');
          if (event == AdmobAdEvent.closed){
            _interstitialAd?.load();
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
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AdmobBanner(
          adUnitId: BaseConstants.bannerAddId,
          adSize: _bannerSize,
          listener: (AdmobAdEvent event,Map<String,dynamic>args){
            print('event : $event');
            print('args : $args');
          },
        ),
        body: BlocListener<LatestEpsCubit, LatestEpsState>(
          listener: (context, state) {
            if (state is LatestEpsSuccess) {
              _checkLatestEpisode();
            }
          },
          child: BlocBuilder<GetDetailAnimeCubit,GetDetailAnimeState>(
            builder:(context,state) {
              if (state is GetDetailAnimeLoading) {
                return MyLoadingScreen();
              }
              if (state is GetDetailAnimeFailure) {
                return ReconnectButton(
                  onReconnect: ()=>context.read<GetDetailAnimeCubit>().fetchDetailAnime(id: widget.id),
                  msg: state.msg,
                );
              }
              if (state is GetDetailAnimeSuccess) {
                final _data = state.data;
                HistoryAnimeModel _historyData = HistoryAnimeModel(
                    endpoint: widget.id,status: _data.status,title: _data.title,thumb: _data.thumb
                );
                _historyAnimeBox.add(_historyData);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: _size.width,
                            height: _size.height * 0.4,
                          ),
                          ShaderMask(
                            shaderCallback: (rect){
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              width: _size.width,
                              // height: _size.height * 0.25,
                              height: _size.height * 0.4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_data.thumb),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: GestureDetector(
                              onTap: ()=>Navigator.pop(context),
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                child: Center(child: Icon(Icons.arrow_back,color: Colors.white,)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: WatchBoxBuilder(
                              box: _saveForLaterBox,
                              builder:(context,save)=> GestureDetector(
                                onTap: (){
                                  final res = SaveForLaterModel(
                                      title: _data.title,endpoint: widget.id,status: _data.status,thumb: _data.thumb
                                  );
                                  if (save.length == 0) {
                                    setState(() {
                                      _isAnimeSaved = true;
                                    });
                                    save.add(res);
                                    Toast.show("Berhasil disimpan", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                  }else{
                                    if (_isAnimeSaved) {
                                      for(int i = 0;i<save.length;i++){
                                        SaveForLaterModel _item = save.getAt(i);
                                        if (_item.endpoint == widget.id) {
                                          save.deleteAt(i);
                                        }
                                      }
                                      setState(() {
                                        _isAnimeSaved = false;
                                      });
                                      Toast.show("Berhasil dihapus", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    } else{
                                      setState(() {
                                        _isAnimeSaved = true;
                                      });
                                      save.add(res);
                                      Toast.show("Berhasil disimpan", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                    }

                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.black.withOpacity(0.6),
                                  child: _isAnimeSaved?Icon(
                                    Icons.favorite,color: Colors.red,
                                  ):Icon(Icons.favorite_border,color: Colors.white,),
                                ),
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
                                      image: NetworkImage(_data.thumb),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Text(_data.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                        child: Table(
                          children: [
                            TableRow(
                                children: [
                                  TableCell(child: Text('Judul jepang'),),
                                  TableCell(child: Text(': ${_data.japanase}'),),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: Text('Score'),),
                                  TableCell(child: Text(': ${_data.score}'),),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: Text('Studio'),),
                                  TableCell(child: Text(': ${_data.studio}'),),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: Text('Status'),),
                                  TableCell(child: Text(': ${_data.status}'),),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: Text('Duration'),),
                                  TableCell(child: Text(': ${_data.duration}'),),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: Text('Tanggal rilis'),),
                                  TableCell(child: Text(': ${_data.releaseDate}'),),
                                ]
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: _size.width,
                        child: ListView.builder(
                          itemCount: _data.genreList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context,i){
                            final _item = _data.genreList[i];
                            return Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              child: Center(child: Text(_item.genreName)),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.red,width: 1,),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text('Sinopsis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Text(_data.synopsis,textAlign: TextAlign.justify,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text('Batch',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: _data.batchLink.id == 'Masih kosong gan'?null:()async{
                              if (await _interstitialAd.isLoaded) {
                                _interstitialAd.show();
                              } else {
                                print('ads wont loaded');
                              }
                            Navigator.pushNamed(context, rBatchAnime,arguments: _data);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1,color: Colors.orange)
                            ),
                            child: Center(
                                child: Text(_data.batchLink.id == 'Masih kosong gan'?_data.batchLink.id:'Download ${_data.title} batch sub indo',textAlign: TextAlign.center,)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('List Episode',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            IconButton(
                              icon: Icon(Icons.sort_by_alpha),
                              onPressed: (){
                                setState(() {
                                  _isEpsReversed = !_isEpsReversed;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      _episode != ''?Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(child: Text('Episode terakhir yang ditonton :\n${_episode.replaceAll(_data.title, '').replaceAll('Subtitle Indonesia', '').trim()}',textAlign: TextAlign.center,)),
                      ):Center(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: _data.episodeList.length,
                          shrinkWrap: true,
                          reverse: _isEpsReversed,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context,i){
                            final _item = _data.episodeList[i];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: ()async{
                                  final _res = LatestEpisodeModel(
                                      animeEndpoint: _animeEndpoint,
                                      episodeEndpoint: _item.id,
                                      episodeTitle: _item.title,
                                      lastEpisode: i
                                  );
                                  setState(() {
                                    _idxLastEps = i;
                                    _episode = _item.title;
                                    _epsId = _item.id;
                                  });
                                  _latestEpisodeBox.add(_res);
                                  if (await _interstitialAd.isLoaded) {
                                    _interstitialAd.show();
                                  } else {
                                    print('ads wont loaded');
                                  }
                                  Future.delayed(Duration(seconds: 2),(){
                                    print('this navigation got printed?');
                                    Navigator.pushNamed(context, rWatchAnime,arguments: WatchAnimeParams(
                                      epsId: _item.id,animeId: widget.id,
                                    ));
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Center(child: Text(_item.title.replaceAll(_data.title, '').replaceAll('Subtitle Indonesia', '').trim(),textAlign: TextAlign.center,)),
                                  decoration: BoxDecoration(
                                      color: _epsId == _item.id?Colors.red:Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1,color: Colors.orange)
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
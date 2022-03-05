import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/search_anime/search_anime_cubit.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';

import '../../routes.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;

  const SearchResultScreen({Key key, this.query}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  AdmobBannerSize _bannerSize;

  @override
  void initState() {
    super.initState();
    context.read<SearchAnimeCubit>().searchAnime(query: widget.query);
    _bannerSize = AdmobBannerSize.BANNER;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil pencarian'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SearchAnimeCubit,SearchAnimeState>(
          builder: (context,state){
            if (state is SearchAnimeLoading) {
              return MyLoadingScreen();
            }
            if (state is SearchAnimeFailure) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(state.msg),),
              );
            }
            if (state is SearchAnimeSuccess) {
              final _data = state.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Hasil pencarian : ${widget.query}',style: TextStyle(fontStyle: FontStyle.italic),),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: AdmobBanner(
                        adUnitId: BaseConstants.bannerAddId,
                        adSize: _bannerSize,
                        listener: (event,args){
                          print('event : $event && args : $args');
                        },
                      ),
                    ),
                    _data.length == 0?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Tidak ditemukan'),
                    ):Center(),
                    ListView.separated(
                      itemCount: _data.length,
                      padding: EdgeInsets.only(top: 15),
                      shrinkWrap: true,
                      separatorBuilder: (context,i)=>Divider(),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,i){
                        final _item = _data[i];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, rDetailAnime,arguments: _item.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(_item.thumb),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(_item.title,style: TextStyle(fontWeight: FontWeight.bold,),),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(_item.status,style: TextStyle(color: Colors.grey),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Icon(Icons.star_border,color: Colors.orange,),
                                              SizedBox(width: 5,),
                                              Text(_item.score.toString(),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                // Text(_item.score.toString())
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
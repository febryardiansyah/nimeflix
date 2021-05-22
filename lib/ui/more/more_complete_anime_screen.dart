import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_complete_anime/get_complete_anime_cubit.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';

class MoreCompleteAnimeScreen extends StatefulWidget {
  MoreCompleteAnimeScreen({Key key}) : super(key: key);

  @override
  _MoreCompleteAnimeScreenState createState() =>
      _MoreCompleteAnimeScreenState();
}

class _MoreCompleteAnimeScreenState extends State<MoreCompleteAnimeScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    context.read<GetCompleteAnimeCubit>().fetchCompleteAnime();
  }
  void _onScrollLoading()async{
    context.read<GetCompleteAnimeCubit>().onScrolling();
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Anime'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetCompleteAnimeCubit,GetCompleteAnimeState>(
          builder: (context,state){
            if (state is GetCompleteAnimeLoading) {
              return MyLoadingScreen();
            }
            if (state is GetCompleteAnimeFailure) {
              return ReconnectButton(msg: state.msg,onReconnect:()=> context.read<GetCompleteAnimeCubit>().fetchCompleteAnime(),);
            }
            if (state is GetCompleteAnimeSuccess) {
              final _data = state.data;
              return SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: _onScrollLoading,
                child: GridView.builder(
                  itemCount: _data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,childAspectRatio: 0.7,mainAxisSpacing: 15,crossAxisSpacing: 15
                  ),
                  itemBuilder: (context,i){
                    final _item = _data[i];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, rDetailAnime,arguments: _item.id);
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 180,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(_item.thumb,),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(_item.episode,style: TextStyle(color: Colors.white,),),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 180,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              child: Center(child: Text(_item.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
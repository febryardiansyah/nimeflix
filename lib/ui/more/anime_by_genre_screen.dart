import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_anime_by_genre/get_anime_by_genre_cubit.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';

class AnimeByGenreScreen extends StatefulWidget {
  final String id;

  const AnimeByGenreScreen({Key key, this.id}) : super(key: key);

  @override
  _AnimeByGenreScreenState createState() => _AnimeByGenreScreenState();
}

class _AnimeByGenreScreenState extends State<AnimeByGenreScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    context.read<GetAnimeByGenreCubit>().fetchAnimeByGenre(id: widget.id);
  }
  void _onScrollLoading()async{
    context.read<GetAnimeByGenreCubit>().onLoading(id: widget.id);
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.replaceAll('/', '')),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<GetAnimeByGenreCubit,GetAnimeByGenreState>(
          builder: (context,state){
            if (state is GetAnimeByGenreLoading) {
              return MyLoadingScreen();
            }
            if (state is GetAnimeByGenreFailure) {
              return ReconnectButton(msg: state.msg,onReconnect: ()=>context.read<GetAnimeByGenreCubit>().fetchAnimeByGenre(id: widget.id),);
            }
            if (state is GetAnimeByGenreSuccess) {
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
                        Navigator.pushNamed(context, rDetailAnime,arguments: _item.id.replaceAll('https://otakudesu.moe/anime/', ''));
                      },
                      child: Stack(
                        children: [
                          // Container(
                          //   width: 180,
                          //   height: MediaQuery.of(context).size.height,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8),
                          //       image: DecorationImage(
                          //           image: NetworkImage(_item.thumb,),
                          //           fit: BoxFit.cover
                          //       )
                          //   ),
                          // ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(_item.episode,style: TextStyle(color: Colors.white,),),
                            color: Colors.red,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 180,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              child: Center(child: Text(_item.animeName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
                              color: Colors.black.withOpacity(0.7),
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_ongoing_anime/get_ongoing_anime_cubit.dart';
import 'package:nimeflix/widgets/item_card_widget.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../routes.dart';

class MoreOngoingAnimeScreen extends StatefulWidget {
  MoreOngoingAnimeScreen({Key key}) : super(key: key);

  @override
  _MoreOngoingAnimeScreenState createState() => _MoreOngoingAnimeScreenState();
}

class _MoreOngoingAnimeScreenState extends State<MoreOngoingAnimeScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    context.read<GetOngoingAnimeCubit>().fetchOngoingAnime();
  }
  void _onScrollLoading()async{
    context.read<GetOngoingAnimeCubit>().onScrolling();
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Anime'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetOngoingAnimeCubit,GetOngoingAnimeState>(
          builder: (context,state){
            if (state is GetOngoingAnimeLoading) {
              return MyLoadingScreen();
            }
            if (state is GetOngoingAnimeFailure) {
              return ReconnectButton(msg: state.msg,onReconnect:()=> context.read<GetOngoingAnimeCubit>().fetchOngoingAnime(),);
            }
            if (state is GetOngoingAnimeSuccess) {
              final _data = state.data;
              print(state.hasReachedMax);
              return SmartRefresher(
                controller: _refreshController,
                enablePullUp: state.hasReachedMax?false:true,
                enablePullDown: false,
                onLoading: state.hasReachedMax?null:_onScrollLoading,
                child: GridView.builder(
                  itemCount: _data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,childAspectRatio: 0.7,mainAxisSpacing: 15,crossAxisSpacing: 15
                  ),
                  itemBuilder: (context,i){
                    final _item = _data[i];
                    return ItemCardWidget(
                      item: ItemCardModel(
                        id: _item.id,
                        episode: _item.episode,
                        thumb: _item.thumb,
                        title: _item.title,
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
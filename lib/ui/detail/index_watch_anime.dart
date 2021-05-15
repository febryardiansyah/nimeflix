import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nimeflix/bloc/get_eps_anime/get_eps_anime_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/ui/detail/watch_anime_screen.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';

class IndexWatchAnime extends StatefulWidget {
  final String id;

  const IndexWatchAnime({Key key, this.id}) : super(key: key);
  @override
  _IndexWatchAnimeState createState() => _IndexWatchAnimeState();
}

class _IndexWatchAnimeState extends State<IndexWatchAnime> {
  @override
  void initState() {
    super.initState();
    context.read<GetEpsAnimeCubit>().fetchEpsAnime(id: widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetEpsAnimeCubit,GetEpsAnimeState>(
        builder: (context,state){
          if (state is GetEpsAnimeLoading) {
            return MyLoadingScreen();
          }
          if (state is GetEpsAnimeFailure) {
            return ReconnectButton(msg: state.msg,onReconnect: ()=>context.read<GetEpsAnimeCubit>().fetchEpsAnime(id: widget.id),);
          }
          if (state is GetEpsAnimeSuccess) {
            return WatchAnimeScreen(data: state.data,);
          }
          return Container();
        },
      ),
    );
  }
}
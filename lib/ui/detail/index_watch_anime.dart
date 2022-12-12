import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_eps_anime/get_eps_anime_cubit.dart';
import 'package:nimeflix/ui/detail/watch_anime_screen.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';

class WatchAnimeParams {
  final String animeId;
  final String epsId;

  WatchAnimeParams({this.animeId, this.epsId});
}

class IndexWatchAnime extends StatefulWidget {
  final WatchAnimeParams data;

  const IndexWatchAnime({Key key, this.data}) : super(key: key);
  @override
  _IndexWatchAnimeState createState() => _IndexWatchAnimeState();
}

class _IndexWatchAnimeState extends State<IndexWatchAnime> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    context.read<GetEpsAnimeCubit>().fetchEpsAnime(id: widget.data.epsId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetEpsAnimeCubit, GetEpsAnimeState>(
        builder: (context, state) {
          if (state is GetEpsAnimeLoading) {
            return MyLoadingScreen();
          }
          if (state is GetEpsAnimeFailure) {
            return ReconnectButton(
              msg: state.msg,
              onReconnect: () => context
                  .read<GetEpsAnimeCubit>()
                  .fetchEpsAnime(id: widget.data.epsId),
            );
          }
          if (state is GetEpsAnimeSuccess) {
            return WatchAnimeScreen(data: state.data,animeId: widget.data.animeId,);
          }
          return Container();
        },
      ),
    );
  }
}
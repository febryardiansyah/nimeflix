import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nimeflix/bloc/get_eps_anime/get_eps_anime_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/ui/detail/watch_anime_screen.dart';

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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingIndicator(indicatorType: Indicator.ballClipRotateMultiple,color: Colors.white,),
                Text('Tunggu sebentar...')
              ],
            );
          }
          if (state is GetEpsAnimeFailure) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.msg),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text('Kembali'),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.white)),
                        onPressed: ()=>Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text('Muat ulang',style: TextStyle(color: Colors.red),),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.red)),
                        onPressed: ()=>context.read<GetEpsAnimeCubit>().fetchEpsAnime(id: widget.id),
                      ),
                    ],
                  ),
                )
              ],
            );
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
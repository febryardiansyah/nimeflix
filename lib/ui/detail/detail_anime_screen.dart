import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nimeflix/bloc/get_detail_anime/get_detail_anime_cubit.dart';
import 'package:nimeflix/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';

class DetailAnimeScreen extends StatefulWidget {
  final String id;

  const DetailAnimeScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailAnimeScreenState createState() => _DetailAnimeScreenState();
}

class _DetailAnimeScreenState extends State<DetailAnimeScreen> {
  Size _size;

  @override
  void initState() {
    super.initState();
    context.read<GetDetailAnimeCubit>().fetchDetailAnime(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<GetDetailAnimeCubit,GetDetailAnimeState>(
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
            return SingleChildScrollView(
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
                                image: NetworkImage(_data.thumb),
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
                      Positioned(
                        top: 20,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: Icon(Icons.bookmark_border,color: Colors.white,),
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
                      child: Text('List Episode',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: _data.episodeList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5,childAspectRatio: 2
                      ),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,i){
                        final _item = _data.episodeList[i];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, rWatchAnime,arguments: _item.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Center(child: Text(_item.title.replaceAll(_data.title, '').replaceAll('Subtitle Indonesia', '').trim(),textAlign: TextAlign.center,)),
                            decoration: BoxDecoration(
                                color: i == 2?Colors.red:Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1,color: Colors.orange)
                            ),
                          ),
                        );
                      },
                    ),
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
                      onTap: _data.batchLink.id == 'Masih kosong gan'?null:(){
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
                            child: Text(_data.batchLink.id == 'Masih kosong gan'?_data.batchLink.id:_data.batchLink.id.split('-').join(' ').replaceAll('/', ''),textAlign: TextAlign.center,)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
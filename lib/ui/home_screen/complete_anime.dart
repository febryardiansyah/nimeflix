import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/widgets/my_shimmer.dart';

class CompleteAnime extends StatefulWidget {
  CompleteAnime({Key key}) : super(key: key);

  @override
  _CompleteAnimeState createState() => _CompleteAnimeState();
}

class _CompleteAnimeState extends State<CompleteAnime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Complete Anime',style: TextStyle(fontSize: 24),),
              Spacer(),
              GestureDetector(
                child: Text('lihat lainnya',style: TextStyle(color: Colors.orange,fontSize: 15),),
                onTap: ()=>Navigator.pushNamed(context, rMoreCompleteAnime),),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            margin: EdgeInsets.only(top: 10),
            child: BlocBuilder<GetHomeCubit,GetHomeState>(
              builder:(context,state) {
                if (state is GetHomeLoading) {
                  return CompleteAnimeShimmer();
                }
                if (state is GetHomeFailure) {
                  return Text(state.msg);
                }
                if (state is GetHomeSuccess) {
                  final _data = state.completeData;
                  return ListView.builder(
                    itemCount: _data.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,i){
                      final _item = _data[i];
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: GestureDetector(
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
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class CompleteAnimeShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,i){
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: MyShimmer(
              child: Container(
                width: 180,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

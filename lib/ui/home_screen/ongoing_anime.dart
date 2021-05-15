import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';

import '../../routes.dart';
import 'complete_anime.dart';

class OngoingAnime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Ongoing Anime',style: TextStyle(fontSize: 24),),
              Spacer(),
              Text('see more',style: TextStyle(color: Colors.orange,fontSize: 15),)
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
                  final _data = state.ongoingData;
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
                                color: Colors.red,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 180,
                                  height: 30,
                                  padding: EdgeInsets.all(8),
                                  child: Center(child: Text(_item.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
                                  color: Colors.black.withOpacity(0.7),
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

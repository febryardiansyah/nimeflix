import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/widgets/item_card_widget.dart';

import '../../routes.dart';
import 'complete_anime.dart';

class OngoingAnime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8
            ),
            child: Row(
              children: [
                Text('Ongoing Anime',style: TextStyle(fontSize: 24),),
                Spacer(),
                GestureDetector(
                  child: Text('lihat lainnya',style: TextStyle(color: Colors.orange,fontSize: 15),),
                  onTap: ()=>Navigator.pushNamed(context, rMoreOngoingAnime),
                )
              ],
            ),
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
                      if (i == 0) {
                        return Row(
                          children: [
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: ItemCardWidget(
                                item: ItemCardModel(
                                  id: _item.id,
                                  episode: _item.episode,
                                  thumb: _item.thumb,
                                  title: _item.title,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: ItemCardWidget(
                          item: ItemCardModel(
                            id: _item.id,
                            episode: _item.episode,
                            thumb: _item.thumb,
                            title: _item.title,
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

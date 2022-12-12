import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/models/complete_anime_model.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/widgets/item_card_widget.dart';
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
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                Text(
                  'Complete Anime',
                  style: TextStyle(fontSize: 24),
                ),
                Spacer(),
                GestureDetector(
                  child: Text(
                    'lihat lainnya',
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                  onTap: () => Navigator.pushNamed(context, rMoreCompleteAnime),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            margin: EdgeInsets.only(top: 10),
            child: BlocBuilder<GetHomeCubit, GetHomeState>(
              builder: (context, state) {
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
                    itemBuilder: (context, i) {
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

  Widget _cardItem(CompleteAnimeModel item) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, rDetailAnime, arguments: item.id);
        },
        child: Stack(
          children: [
            Container(
              width: 180,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                      item.thumb,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                item.episode,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
                child: Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
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
        itemBuilder: (context, i) {
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

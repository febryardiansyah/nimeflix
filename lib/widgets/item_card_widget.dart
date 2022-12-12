import 'package:flutter/material.dart';
import 'package:nimeflix/routes.dart';

class ItemCardModel {
  final String id;
  final String thumb;
  final String episode;
  final String title;

  ItemCardModel({this.id, this.thumb, this.episode, this.title});
}

class ItemCardWidget extends StatelessWidget {
  final ItemCardModel item;
  const ItemCardWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                fit: BoxFit.cover,
              ),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
              ),
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)
                ),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          )
        ],
      ),
    );
  }
}

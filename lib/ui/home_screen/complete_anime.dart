import 'package:flutter/material.dart';

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
              Text('see all',style: TextStyle(color: Colors.orange,fontSize: 15),)
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,i){
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      Container(
                        width: 180,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage('https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg',),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text('Episode 6',style: TextStyle(color: Colors.white,),),
                        color: Colors.red,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 180,
                          height: 30,
                          padding: EdgeInsets.all(8),
                          child: Center(child: Text('CSGO',style: TextStyle(color: Colors.white),),),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
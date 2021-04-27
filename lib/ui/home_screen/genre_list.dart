import 'package:flutter/material.dart';

class GenreList extends StatefulWidget {
  GenreList({Key key}) : super(key: key);

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Genres',style: TextStyle(fontSize: 24),),
          GridView.builder(
            itemCount: 10,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 5
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,i){
              return Stack(
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
                    width: 180,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Comedy',style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
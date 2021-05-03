import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';

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
          BlocBuilder<GetGenresCubit,GetGenresState>(
            builder: (context,state){
              if (state is GetGenresLoading) {
                return Text('loading');
              }
              if (state is GetGenresFailure) {
                return Text(state.msg);
              }
              if (state is GetGenresSuccess) {
                final _data = state.data;
                return GridView.builder(
                  itemCount: _data.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,mainAxisSpacing: 12,crossAxisSpacing: 10,childAspectRatio: 5
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,i){
                    final _item = _data[i];
                    return Stack(
                      children: [
                        Container(
                          width: 180,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white,width: 1),
                              image: DecorationImage(
                                  image: NetworkImage(_item.imageLink == 'https://cdn.myanimelist.net/images/anime/5/65187.webp'?'https://cdn.myanimelist.net/images/anime/1331/111940.jpg':_item.imageLink),
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
                          child: Text(_item.genreName,style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    );
                  },
                );
            }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
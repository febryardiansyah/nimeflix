import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/search_anime/search_anime_cubit.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/utils/helpers.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _query = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (val){
              context.read<SearchAnimeCubit>().searchAnime(query: _query.text);
              setState(() {
                _query.text = null;
              });
            },
            onChanged: (val){
              setState(() {
                _query = _query;
              });
            },
            controller: _query,
            decoration: InputDecoration(
                hintText: 'Search anime..',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                suffixIcon: _query.text.isEmpty?null:IconButton(
                  icon: Icon(Icons.send,color: Colors.red,),
                  onPressed: (){
                    Helpers.requestNode(context);
                    context.read<SearchAnimeCubit>().searchAnime(query: _query.text);
                  },
                )
            ),
          ),
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: BlocBuilder<SearchAnimeCubit,SearchAnimeState>(
              builder: (context,state){
                if (state is SearchAnimeLoading) {
                  return MyLoadingScreen();
                }
                if (state is SearchAnimeFailure) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(state.msg),),
                  );
                }
                if (state is SearchAnimeSuccess) {
                  final _data = state.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Hasil pencarian : ${_query.text}',style: TextStyle(fontStyle: FontStyle.italic),),
                        _data.length == 0?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tidak ditemukan'),
                        ):Center(),
                        ListView.separated(
                          itemCount: _data.length,
                          padding: EdgeInsets.only(top: 15),
                          shrinkWrap: true,
                          separatorBuilder: (context,i)=>Divider(),
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context,i){
                            final _item = _data[i];
                            return GestureDetector(
                              onTap: ()=>Navigator.pushNamed(context, rDetailAnime,arguments: _item.id),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(_item.thumb),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(_item.title,style: TextStyle(fontWeight: FontWeight.bold,),),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(_item.status,style: TextStyle(color: Colors.grey),),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.star_border,color: Colors.orange,),
                                                  SizedBox(width: 5,),
                                                  Text(_item.score.toString(),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                    // Text(_item.score.toString())
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

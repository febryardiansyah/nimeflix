import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/utils/helpers.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _query = TextEditingController();

  final _searchBox = Hive.box(BaseConstants.hSearchHistory);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autofocus: true,
            onFieldSubmitted: (val){
              Navigator.pushNamed(context, rSearchResult,arguments: _query.text);
              _searchBox.add(_query.text);
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
                border: InputBorder.none,
                suffixIcon: _query.text.isEmpty?null:IconButton(
                  icon: Icon(Icons.close,color: Colors.red,),
                  onPressed: (){
                    _query.clear();
                  },
                )
            ),
          ),
          elevation: 0,
        ),
        body: WatchBoxBuilder(
          box: _searchBox,
          builder: (context,box)=> ListView.builder(
            itemCount: box.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,i){
              final _item = box.getAt(i);
              return Material(
                color: Colors.white,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, rSearchResult,arguments: _item);
                  },
                  leading: Icon(Icons.history,color: Colors.grey,),
                  title: Text(_item,style: TextStyle(color: Colors.black),),
                  trailing: IconButton(
                    icon: Icon(Icons.close,color: Colors.grey,),
                    onPressed: (){
                      box.deleteAt(i);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

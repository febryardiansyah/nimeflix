import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/utils/hive_database/history_anime_model.dart';

class MoreHistoryAnimeScreen extends StatefulWidget {
  MoreHistoryAnimeScreen({Key key}) : super(key: key);

  @override
  _MoreHistoryAnimeScreenState createState() => _MoreHistoryAnimeScreenState();
}

class _MoreHistoryAnimeScreenState extends State<MoreHistoryAnimeScreen> {
  final _box = Hive.box(BaseConstants.hHistoryAnime);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terakhir dilihat'),
        elevation: 0,
        actions: [
          _box.length == 0?Center():FlatButton(onPressed: (){
            _box.clear();
          }, child: Text('Hapus semua'))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: WatchBoxBuilder(
          box: _box,
          builder: (context,box){
            final _reversed = List.from(box.values.toList().reversed);
            if (box.length == 0) {
              return Center(
                child: Text('Masih kosong'),
              );
            }
            return ListView.separated(
              separatorBuilder: (context,i)=>Divider(),
              // itemCount: box.length,
              itemCount: _reversed.length,
              itemBuilder: (context,i){
                HistoryAnimeModel _item = _box.getAt(i);
                return ListTile(
                  leading: Image.network(_item.thumb),
                  title: Text(_item.title),
                  subtitle: Text(_item.status),
                  onTap: (){
                    Navigator.pushNamed(context, rDetailAnime,arguments: _item.endpoint);
                  },
                  trailing: IconButton(icon: Icon(Icons.delete_outline),color: Colors.red,onPressed: (){
                    _box.deleteAt(i);
                  },),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
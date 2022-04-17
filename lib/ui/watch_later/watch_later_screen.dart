import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/utils/hive_database/save_for_later_model.dart';

class WatchLaterScreen extends StatefulWidget {
  WatchLaterScreen({Key key}) : super(key: key);

  @override
  _WatchLaterScreenState createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {
  final _saveForLaterBox = Hive.openBox(BaseConstants.hSaveForLater);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tonton nanti'),
        elevation: 0,
        actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, rSearch), icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: _saveForLaterBox,
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('${BaseConstants.errorMessage} : ${snapshot.error}'),);
              } else{
                return _buildList();
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildList(){
    final _box = Hive.box(BaseConstants.hSaveForLater);
    return WatchBoxBuilder(
      box: _box,
      builder: (context,saved){
        if (saved.isEmpty) {
          return Center(child: Text('Masih kosong'),);
        }
        return ListView.builder(
          itemCount: saved.length,
          itemBuilder: (context,i){
            SaveForLaterModel _item = _box.getAt(i);
            return ListTile(
              onTap: (){
                print(_item.endpoint);
                Navigator.pushNamed(context, rDetailAnime,arguments: _item.endpoint);
              },
              leading: Image.network(_item.thumb,fit: BoxFit.cover,),
              title: Text(_item.title.length > 30?'${_item.title.substring(0,30)}..':_item.title,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(_item.status),
              trailing: FlatButton(
                child: Text('Hapus',style: TextStyle(color: Colors.red),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(width: 1, color: Colors.red)
                ),
                onPressed: (){
                  _box.deleteAt(i);
                },
              ),
            );
          },
        );
      },
    );
  }
}
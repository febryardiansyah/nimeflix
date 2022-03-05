import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_schedule/get_schedule_cubit.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/widgets/my_loading_screen.dart';
import 'package:nimeflix/widgets/reconnect_button.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetScheduleCubit>().fetchSchedule();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Rilis'),
        elevation: 0,
        actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, rSearch), icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetScheduleCubit,GetScheduleState>(
          builder: (context,state){
            if (state is GetScheduleLoading) {
              return MyLoadingScreen();
            }
            if (state is GetScheduleFailure) {
              return ReconnectButton(msg: state.msg,onReconnect: ()=>context.read<GetScheduleCubit>().fetchSchedule(),);
            }
            if (state is GetScheduleSuccess) {
              final _data = state.data;
              return ListView.separated(
                itemCount: _data.length,
                separatorBuilder: (context,i)=>Divider(),
                itemBuilder: (context,i){
                  final _item = _data[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_item.day,style: TextStyle(color: Colors.orange,fontSize: 24),),
                      ListView.builder(
                        itemCount: _item.animeList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context,i){
                          final _anime = _item.animeList[i];
                          return ListTile(
                            leading: Icon(Icons.movie),
                            title: Text(_anime.animeName),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: ()=>Navigator.pushNamed(context, rDetailAnime,arguments: _anime.id),
                          );
                        },
                      )
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
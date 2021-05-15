import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nimeflix/bloc/get_batch_anime/get_batch_anime_cubit.dart';
import 'package:nimeflix/bloc/get_complete_anime/get_complete_anime_cubit.dart';
import 'package:nimeflix/bloc/get_detail_anime/get_detail_anime_cubit.dart';
import 'package:nimeflix/bloc/get_eps_anime/get_eps_anime_cubit.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';
import 'package:nimeflix/bloc/get_ongoing_anime/get_ongoing_anime_cubit.dart';
import 'package:nimeflix/bloc/get_schedule/get_schedule_cubit.dart';
import 'package:nimeflix/bloc/search_anime/search_anime_cubit.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:nimeflix/routes.dart';

import 'bloc/get_home/get_home_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(_dir.path);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp])
  .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetHomeCubit(),
        ),
        BlocProvider(
          create: (_) => GetGenresCubit(),
        ),
        BlocProvider(
          create: (_) => GetDetailAnimeCubit(),
        ),
        BlocProvider(
          create: (_) => GetEpsAnimeCubit(),
        ),
        BlocProvider(
          create: (_) => GetBatchAnimeCubit(),
        ),
        BlocProvider(
          create: (_) => SearchAnimeCubit(),
        ),
        BlocProvider(
          create: (_) => GetScheduleCubit(),
        ),
        BlocProvider(
          create: (_) => GetCompleteAnimeCubit(),
        ),
        BlocProvider(
          create: (_) => GetOngoingAnimeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: rBottomNav,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

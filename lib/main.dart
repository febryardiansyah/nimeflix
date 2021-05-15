import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_batch_anime/get_batch_anime_cubit.dart';
import 'package:nimeflix/bloc/get_detail_anime/get_detail_anime_cubit.dart';
import 'package:nimeflix/bloc/get_eps_anime/get_eps_anime_cubit.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';
import 'package:nimeflix/bloc/get_schedule/get_schedule_cubit.dart';
import 'package:nimeflix/bloc/search_anime/search_anime_cubit.dart';

import 'package:nimeflix/routes.dart';

import 'bloc/get_home/get_home_cubit.dart';

void main() {
  runApp(MyApp());
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

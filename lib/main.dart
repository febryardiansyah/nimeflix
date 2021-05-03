import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_genres/get_genres_cubit.dart';

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

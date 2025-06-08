import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:thesis_app/controllers/cubit/auth/auth_cubit.dart';
import 'package:thesis_app/controllers/cubit/stream/stream_cubit.dart';
import 'package:thesis_app/views/auth/login.dart';
import 'package:thesis_app/views/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => StreamCubit()),
      ],
      child: MaterialApp(
        title: 'Live shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 178, 242, 187),
          ),
        ),
        home: _checkLogin(context) ? Home() : Login(),
      ),
    );
  }
}

dynamic _checkLogin(BuildContext context) {
  final myBox = Hive.box('db');
  if (myBox.isEmpty) {
    return false;
  }
  final accessToken = myBox.get("token") as String;
  final jwt = JWT.decode(accessToken);
  return DateTime.fromMillisecondsSinceEpoch(
    jwt.payload["exp"] * 1000,
  ).isAfter(DateTime.now());
}

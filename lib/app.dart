import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:stream_video/stream_video.dart';
import 'package:thesis_app/constants/environement_var.dart';
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

bool _checkLogin(BuildContext context) {
  final myBox = Hive.box('db');
  final accessToken = myBox.get("token");

  final user = myBox.get('user');
  if (user != null) {
    final streamToken = myBox.get('streamToken') as String?;
    final StreamCubit streamCubit = StreamCubit();
    if (StreamVideo != null) {
      StreamVideo.reset();
      StreamVideo(
        streamApiKey,
        user: User(info: UserInfo(name: user.username, id: user.id)),
        userToken: streamToken,
        tokenLoader: (userId) async {
          final token = await streamCubit.getStreamUserToken();
          return token["token"];
        },
      );
    }

    final jwt = JWT.decode(accessToken);
    return DateTime.fromMillisecondsSinceEpoch(
      jwt.payload["exp"] * 1000,
    ).isBefore(DateTime.now());
  }
  return false;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:thesis_app/controllers/cubit/auth/auth_cubit.dart';
import 'package:thesis_app/controllers/cubit/stream/stream_cubit.dart';
import 'package:thesis_app/models/user.dart';
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
        home: Builder(
          builder: (context) {
            final myBox = Hive.box('db');

            final user = myBox.get('user') as User?;

            if (user == null) {
              return Login();
            }
            return Home();
          },
        ),
      ),
    );
  }
}

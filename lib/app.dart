import 'package:flutter/material.dart';
import 'package:thesis_app/views/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 178, 242, 187),
        ),
      ),
      home: Builder(
        builder: (context) {
          return Home();
        },
      ),
    );
  }
}

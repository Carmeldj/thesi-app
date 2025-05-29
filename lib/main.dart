import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:thesis_app/app.dart';
import 'package:thesis_app/constants/environement_var.dart';
import 'hive/hive_registrar.g.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapters();

  await Hive.openBox('db');

  final myBox = Hive.box('db');
  final user = myBox.get('user');
  final streamToken = myBox.get('streamToken') as String?;

  StreamVideo(
    streamApiKey,
    user: User(info: UserInfo(name: user.firstname, id: user.id)),
    userToken: streamToken,
  );

  runApp(const MyApp());
}

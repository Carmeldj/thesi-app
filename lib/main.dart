import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:thesis_app/app.dart';
import 'hive/hive_registrar.g.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapters();

  await Hive.openBox('db');

  runApp(const MyApp());
}

import 'package:hive_ce/hive.dart';

import 'package:thesis_app/models/user/user.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<User>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}

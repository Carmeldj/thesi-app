import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:thesis_app/views/auth/login.dart';

class ProfilePage extends StatelessWidget {
  final myBox = Hive.box('db');
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          myBox.delete("user");
          myBox.delete("token");
          myBox.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (route) => false,
          );
        },
        child: Text('Logout'),
      ),
    );
  }
}

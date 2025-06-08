import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:stream_video/stream_video.dart';
import 'package:thesis_app/constants/environement_var.dart';
import 'package:thesis_app/controllers/cubit/stream/stream_cubit.dart';
import 'package:thesis_app/views/live_pages/go_live_page.dart';
import 'package:thesis_app/views/shop_pages/home_page.dart';
import 'package:thesis_app/views/profile.dart';
import 'package:thesis_app/views/sold_products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  final myBox = Hive.box('db');
  final List<Widget> pages = <Widget>[
    HomePage(),
    GoLivePage(),
    SoldProductsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = myBox.get('user');
    final streamToken = myBox.get('streamToken') as String?;
    final StreamCubit streamCubit = StreamCubit();

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

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Acceuil',
          ),

          NavigationDestination(
            icon: Icon(Icons.live_tv_sharp),
            selectedIcon: Icon(Icons.live_tv),
            label: 'Live',
          ),

          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Boutique',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}

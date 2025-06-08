import 'package:flutter/material.dart';
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

  final List<Widget> pages = <Widget>[
    HomePage(),
    GoLivePage(),
    SoldProductsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
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

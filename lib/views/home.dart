import 'package:flutter/material.dart';
import 'package:thesis_app/views/live_pages/live.dart';
import 'package:thesis_app/views/shop_pages/my_shop.dart';
import 'package:thesis_app/views/profile.dart';
import 'package:thesis_app/views/sold_products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> pages = [
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => MyShopPage());
      },
    ),
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => LivePage());
      },
    ),
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => SoldProductsPage());
      },
    ),
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => ProfilePage());
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool dipPop, dynamic result) async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentPageIndex].currentState!.maybePop();
        if (dipPop) {
          return;
        }
        if (isFirstRouteInCurrentTab) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 50,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: const Color.fromARGB(255, 178, 242, 187),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.shopping_basket),
              label: 'Ma Boutique',
            ),
            NavigationDestination(icon: Icon(Icons.live_tv), label: 'Live'),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Produits vendus',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: Stack(
          children: List.generate(pages.length, (index) {
            return Offstage(
              offstage: currentPageIndex != index,
              child: Navigator(
                key: navigatorKeys[index],
                onGenerateRoute: (settings) {
                  Widget page;
                  if (index == 0) {
                    page = MyShopPage();
                  } else if (index == 1) {
                    page = LivePage();
                  } else if (index == 2) {
                    page = SoldProductsPage();
                  } else {
                    page = ProfilePage();
                  }
                  return MaterialPageRoute(builder: (_) => page);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

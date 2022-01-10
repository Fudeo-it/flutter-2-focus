import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
        routes: [
          ContentRoute(content: 'A'),
          ContentRoute(content: 'B'),
          ContentRoute(content: 'C'),
        ],
        builder: (context, child, animation) => child,
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              label: 'A',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              label: 'B',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              label: 'C',
            ),
          ],
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        ),
      );
}

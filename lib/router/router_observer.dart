import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouterObserver extends AutoRouterObserver {

  @override
  void didPush(Route route, Route? prev) {
    print('Sto navigando verso questa rotta: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? prev) {
    print('Ho navigato verso questa tab: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute prev) {
    print('Sto rinavigando verso questa tab: ${route.name}');
  }
}
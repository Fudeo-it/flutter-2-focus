// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:auto_route_example/pages/auth_page.dart' as _i1;
import 'package:auto_route_example/pages/content_page.dart' as _i3;
import 'package:auto_route_example/pages/home_page.dart' as _i2;
import 'package:auto_route_example/router/auth_guard.dart' as _i6;
import 'package:flutter/material.dart' as _i5;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i6.AuthGuard authGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      final args = routeData.argsAs<AuthRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.AuthPage(key: args.key, onResult: args.onResult));
    },
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    ContentRoute.name: (routeData) {
      final args = routeData.argsAs<ContentRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ContentPage(args.content, key: args.key));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(AuthRoute.name, path: '/auth-page'),
        _i4.RouteConfig(HomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i4.RouteConfig(ContentRoute.name,
              path: 'content-page', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i4.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({_i5.Key? key, required dynamic Function(bool) onResult})
      : super(AuthRoute.name,
            path: '/auth-page',
            args: AuthRouteArgs(key: key, onResult: onResult));

  static const String name = 'AuthRoute';
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key, required this.onResult});

  final _i5.Key? key;

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.ContentPage]
class ContentRoute extends _i4.PageRouteInfo<ContentRouteArgs> {
  ContentRoute({required String content, _i5.Key? key})
      : super(ContentRoute.name,
            path: 'content-page',
            args: ContentRouteArgs(content: content, key: key));

  static const String name = 'ContentRoute';
}

class ContentRouteArgs {
  const ContentRouteArgs({required this.content, this.key});

  final String content;

  final _i5.Key? key;

  @override
  String toString() {
    return 'ContentRouteArgs{content: $content, key: $key}';
  }
}

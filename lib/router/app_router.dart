import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/pages/auth_page.dart';
import 'package:auto_route_example/pages/content_page.dart';
import 'package:auto_route_example/pages/home_page.dart';
import 'package:auto_route_example/router/auth_guard.dart';

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    preferRelativeImports: false,
    routes: <AutoRoute>[
      AutoRoute(page: AuthPage),
      AutoRoute(
        page: HomePage,
        children: [AutoRoute(page: ContentPage)],
        guards: [
          AuthGuard,
        ],
        initial: true,
      ),
    ])
class $AppRouter {}

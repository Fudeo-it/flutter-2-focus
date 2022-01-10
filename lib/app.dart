import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/cubits/auth_cubit.dart';
import 'package:auto_route_example/router/app_router.gr.dart';
import 'package:auto_route_example/router/auth_guard.dart';
import 'package:auto_route_example/router/router_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRouter? _appRouter;
  final _authCubit = AuthCubit();

  @override
  void initState() {
    _appRouter = AppRouter(authGuard: AuthGuard(_authCubit));

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: AutoRouterDelegate(_appRouter!,
            navigatorObservers: () => [RouterObserver()]),
        routeInformationParser: _appRouter!.defaultRouteParser(),
      ),
    );
  }

  @override
  void dispose() async {
    await _authCubit.close();

    super.dispose();
  }
}

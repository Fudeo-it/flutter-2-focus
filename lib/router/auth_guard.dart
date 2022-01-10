import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/cubits/auth_cubit.dart';
import 'package:auto_route_example/router/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {

  final AuthCubit _authCubit;

  AuthGuard(this._authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authCubit.state) {
      resolver.next(true);
    } else {
      router.push(AuthRoute(onResult: (success) {
        resolver.next(success);
      }));
    }
  }

}
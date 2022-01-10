import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/pages/home_page.dart';
import 'package:social_network/pages/welcome_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => state is CheckAuthenticationState
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : state is AuthenticatedState
                ? HomePage(user: state.user)
                : const WelcomePage(),
      );
}

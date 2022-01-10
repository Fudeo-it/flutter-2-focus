import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/models/user.dart';
import 'package:social_network/theme.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        drawer: _drawer(context),
        body: Container(
          padding: const EdgeInsets.all(64.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomTheme.gradientStart,
                CustomTheme.gradientEnd,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
            ),
          ),
          child: _welcomeWidget(),
        ),
      );

  Widget _welcomeWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/login_logo.png'),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: RichText(
                text: TextSpan(
                  text: 'Benvenuto, ',
                  style: const TextStyle(fontSize: 36.0),
                  children: [
                    TextSpan(
                      text: user.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _drawer(BuildContext context) => Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _accountHeader(),
                ],
              ),
            ),
            const Divider(height: 0),
            _logoutButton(context),
          ],
        ),
      );

  Widget _accountHeader() => UserAccountsDrawerHeader(
        accountName: Text(user.name),
        accountEmail: Text(user.email),
        currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white, child: Text(user.initials)),
      );

  Widget _logoutButton(BuildContext context) => ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Esci'),
        onTap: () => context.read<AuthCubit>().logout(),
      );
}

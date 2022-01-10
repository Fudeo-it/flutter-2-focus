import 'package:flutter/material.dart';
import 'package:social_network/pages/login_page.dart';
import 'package:social_network/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
          child: Column(
            children: [
              _welcomeWidget(),
              _signInButton(context),
            ],
          ),
        ),
      );

  Widget _welcomeWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/login_logo.png'),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.only(top: 48.0),
              child: Text(
                'Social App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _signInButton(BuildContext context) => ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 48.0,
          ),
          child: Text(
            'INIZIA',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      );
}

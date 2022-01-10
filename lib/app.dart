import 'package:flutter/material.dart';
import 'package:social_network/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Social App',
        home: WelcomePage(),
        debugShowCheckedModeBanner: false,
      );
}

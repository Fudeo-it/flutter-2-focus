import 'package:flutter/material.dart';
import 'package:food_delivery/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Delivery',
        home: WelcomePage(),
      );
}

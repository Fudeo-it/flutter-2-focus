import 'package:flutter/material.dart';
import 'package:food_delivery/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme(context),
        title: 'Food Delivery',
        home: const WelcomePage(),
      );

  ThemeData _theme(BuildContext context) {
    final primaryColor = Colors.red[700]!;
    final primaryColorDark = Colors.red[900]!;
    final secondaryColor = Colors.orangeAccent[100]!;
    final onSecondaryColor = Colors.grey[100]!;

    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: secondaryColor,
        onSecondary: onSecondaryColor,
      ),
      brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: const TextTheme(
        headline4: TextStyle(color: Colors.black87),
      ),
    );
  }
}

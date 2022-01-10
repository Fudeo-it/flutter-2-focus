import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/cubits/dark_mode_cubit.dart';
import 'package:food_delivery/flavors.dart';
import 'package:food_delivery/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(_) => BlocProvider(
        create: (_) => DarkModeCubit(),
        child: _themeSelector(
          (context, mode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _theme(context),
            darkTheme: _darkTheme(context),
            themeMode: mode,
            title: F.title,
            home: const WelcomePage(),
          ),
        ),
      );

  Widget _themeSelector(
          Widget Function(BuildContext context, ThemeMode mode) builder) =>
      BlocBuilder<DarkModeCubit, bool>(
        builder: (context, darkModeEnabled) => builder(
          context,
          darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        ),
      );

  ThemeData _theme(BuildContext context) {
    final primaryColor = F.primaryColor!;
    final primaryColorDark = F.primaryColorDark!;
    final secondaryColor = F.secondaryColor!;
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
      fontFamily: F.fontFamily,
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

  ThemeData _darkTheme(BuildContext context) {
    final primaryColor = Colors.red[700]!;
    final primaryColorDark = Colors.red[900]!;
    final secondaryColor = Colors.orangeAccent[100]!;
    final surfaceColor = Colors.black26;

    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
      ),
      brightness: Brightness.dark,
      fontFamily: F.fontFamily,
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
        headline4: TextStyle(color: Colors.white),
      ),
    );
  }
}

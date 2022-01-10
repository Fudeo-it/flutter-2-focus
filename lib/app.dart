import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/pages/welcome_page.dart';
import 'package:social_network/services/image_picker_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Provider(
        create: (_) => ImagePickerService(),
        child: const MaterialApp(
          title: 'Social App',
          home: WelcomePage(),
          debugShowCheckedModeBanner: false,
        ),
      );
}

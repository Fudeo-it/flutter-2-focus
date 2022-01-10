import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_network/cubits/auth/auth_cubit.dart';
import 'package:social_network/pages/main_page.dart';
import 'package:social_network/repositories/user_repository.dart';
import 'package:social_network/services/auth_service.dart';
import 'package:social_network/services/image_picker_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (_) => ImagePickerService(),
          ),
          Provider(
            create: (_) => AuthService(),
          ),
          Provider(
            create: (_) => Logger(),
          ),
          Provider(
            create: (_) => const FlutterSecureStorage(),
          ),
        ],
        child: RepositoryProvider(
          create: (context) => UserRepository(
            authService: context.read(),
            secureStorage: context.read(),
            logger: context.read(),
          ),
          child: BlocProvider(
            create: (context) => AuthCubit(
              userRepository: context.read(),
            )..checkAuthenticationState(),
            child: const MaterialApp(
              title: 'Social App',
              home: MainPage(),
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      );
}

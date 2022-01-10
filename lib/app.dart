import 'package:crypto_app/network/rest_client.dart';
import 'package:crypto_app/pages/home_page.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => RepositoryProvider(
      create: (_) => CoinRepository(restClient: RestClient(Dio())),
      child: MaterialApp(
        title: 'Crypto App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage(),
      ),
    );
}
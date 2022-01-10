import 'package:auto_route_example/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  final Function(bool) onResult;

  const AuthPage({
    Key? key,
    required this.onResult,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthCubit, bool>(
        listener: (context, authenticated) {
          if (authenticated) {
            widget.onResult(authenticated);
          }
        },
        child: Scaffold(
            appBar: AppBar(title: const Text('Autenticati')),
            body: Column(
              children: [
                _passwordField(),
                _confirmButton(context),
              ],
            )),
      );

  Widget _passwordField() =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _passwordController,
          decoration: const InputDecoration(hintText: 'Password'),
          obscureText: true,
        ),
      );

  Widget _confirmButton(BuildContext context) =>
      ElevatedButton(
        child: const Text('Conferma'),
        onPressed: () {
          context.read<AuthCubit>().authenticate(_passwordController.text);
        },
      );
}

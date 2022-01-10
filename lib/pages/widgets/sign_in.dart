import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureTextPassword = true;

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _formWidget(),
                _signInButton(),
              ],
            ),
            _forgotPasswordButton(),
          ],
        ),
      );

  Widget _formWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 24.0,
            ),
            width: 300.0,
            child: Column(
              children: [
                _emailField(),
                const Divider(height: 0),
                _passwordField(),
              ],
            ),
          ),
        ),
      );

  Widget _emailField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextField(
          focusNode: _focusNodeEmail,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Indirizzo Email',
            hintStyle: TextStyle(fontSize: 17.0),
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 22.0,
            ),
          ),
          onSubmitted: (_) {
            _focusNodePassword.requestFocus();
          },
        ),
      );

  Widget _passwordField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextField(
          focusNode: _focusNodePassword,
          obscureText: _obscureTextPassword,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle: const TextStyle(fontSize: 17.0),
            icon: const Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
              size: 22.0,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureTextPassword = !_obscureTextPassword;
                });
              },
              child: Icon(
                _obscureTextPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          onSubmitted: (_) {
            //TODO: Login
          },
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signInButton() => ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 48.0,
          ),
          child: Text(
            'ACCEDI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
        onPressed: () {},
      );

  Widget _forgotPasswordButton() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Password dimenticata?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
}

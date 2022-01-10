import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final _focusNodeName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: [
            Stack(
              children: [
                _formWidget(),
                _avatarWidget(),
                _signUpButton(),
              ],
            ),
          ],
        ),
      );

  Widget _avatarWidget() => Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48.0),
            ),
            elevation: 8,
            child: const CircleAvatar(
              radius: 48.0,
              child: Icon(
                FontAwesomeIcons.camera,
                size: 24.0,
              ),
            ),
          ),
        ),
      );

  Widget _formWidget() => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0, bottom: 16.0),
          child: Card(
            elevation: 2.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 32.0,
                bottom: 24.0,
              ),
              width: 300.0,
              child: Column(
                children: [
                  _nameField(),
                  const Divider(height: 0),
                  _emailField(),
                  const Divider(height: 0),
                  _passwordField(),
                  const Divider(height: 0),
                  _confirmPasswordField(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _nameField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextField(
          focusNode: _focusNodeName,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Nome',
            hintStyle: TextStyle(fontSize: 17.0),
            icon: Icon(
              FontAwesomeIcons.user,
              color: Colors.black,
              size: 22.0,
            ),
          ),
          onSubmitted: (_) {
            _focusNodeEmail.requestFocus();
          },
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
            _focusNodeConfirmPassword.requestFocus();
          },
        ),
      );

  Widget _confirmPasswordField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextField(
          focusNode: _focusNodeConfirmPassword,
          obscureText: _obscureTextConfirmPassword,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Conferma Password',
            hintStyle: const TextStyle(fontSize: 17.0),
            icon: const Icon(
              FontAwesomeIcons.lock,
              color: Colors.black,
              size: 22.0,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                });
              },
              child: Icon(
                _obscureTextConfirmPassword
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

  Widget _signUpButton() => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 48.0,
              ),
              child: Text(
                'INVIA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
            onPressed: () {},
          ),
        ),
      );
}

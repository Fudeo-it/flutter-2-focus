import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network/blocs/sign_in/sign_in_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _formValid = false;

  bool _obscureTextPassword = true;

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(_) => BlocProvider(
        create: (context) => SignInBloc(
          userRepository: context.read(),
        ),
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            _shouldNavigateToMainPage(context, state: state);
            _shouldShowErrorSignInDialog(context, state: state);
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: () {
                      final isValid =
                          _formKey.currentState?.validate() ?? false;
                      setState(() {
                        _formValid = isValid;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _formWidget(context, enabled: state is! SigningInState),
                        _signInButton(context,
                            loading: state is SigningInState),
                      ],
                    ),
                  ),
                  _forgotPasswordButton(),
                ],
              ),
            );
          },
        ),
      );

  Widget _formWidget(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
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
                _emailField(enabled: enabled),
                const Divider(height: 0),
                _passwordField(context, enabled: enabled),
              ],
            ),
          ),
        ),
      );

  Widget _emailField({
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextFormField(
          enabled: enabled,
          controller: _signInEmailController,
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
            errorStyle: TextStyle(
              fontSize: 10,
              height: 0.1,
            ),
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 22.0,
            ),
          ),
          validator: (value) {
            const regex =
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
            if (!RegExp(regex).hasMatch(value ?? '')) {
              return 'Email non valida';
            }
          },
          onFieldSubmitted: (_) {
            _focusNodePassword.requestFocus();
          },
        ),
      );

  Widget _passwordField(
    BuildContext context, {
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextFormField(
          enabled: enabled,
          controller: _signInPasswordController,
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
            errorStyle: const TextStyle(
              fontSize: 10,
              height: 0.1,
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
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password troppo corta';
            }
          },
          onFieldSubmitted: (_) => context.read<SignInBloc>().signIn(
                email: _signInEmailController.text,
                password: _signInPasswordController.text,
              ),
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signInButton(
    BuildContext context, {
    bool loading = false,
  }) =>
      ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 48.0,
          ),
          child: !loading
              ? const Text(
                  'ACCEDI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                )
              : const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
        ),
        onPressed: !loading && _formValid
            ? () => context.read<SignInBloc>().signIn(
                  email: _signInEmailController.text,
                  password: _signInPasswordController.text,
                )
            : null,
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

  void _shouldNavigateToMainPage(
    BuildContext context, {
    required SignInState state,
  }) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (state is SignedInState) {
        Navigator.of(context).pop();
      }
    });
  }

  void _shouldShowErrorSignInDialog(
    BuildContext context, {
    required SignInState state,
  }) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (state is SignInErrorState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Problemi durante il login'),
            content: const Text('Email o password errata.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    });
  }
}

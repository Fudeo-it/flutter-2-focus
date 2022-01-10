import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network/blocs/image_picker/image_picker_bloc.dart';
import 'package:social_network/services/image_picker_service.dart';
import 'package:social_network/widgets/bottom_sheet_action.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _formValid = false;

  final _focusNodeName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();

  final _signUpEmailController = TextEditingController();
  final _signUpNameController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ImagePickerBloc(
            imagePickerService: context.read<ImagePickerService>()),
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  setState(() {
                    _formValid = isValid;
                  });
                },
                child: Stack(
                  children: [
                    _formWidget(),
                    _avatarWidget(context),
                    _signUpButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _avatarWidget(BuildContext context) => Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48.0),
            ),
            elevation: 8,
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) => InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => _bottomSheetPicker(context,
                        picked: state is PickedImageState),
                  );
                },
                child: CircleAvatar(
                    backgroundImage: state is PickedImageState
                        ? FileImage(state.imageFile)
                        : null,
                    radius: 48.0,
                    child: () {
                      if (state is NoImagePickedState) {
                        return const Icon(
                          FontAwesomeIcons.camera,
                          size: 24.0,
                        );
                      } else if (state is LoadingImageState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Container();
                    }()),
              ),
            ),
          ),
        ),
      );

  Widget _bottomSheetPicker(
    BuildContext context, {
    bool picked = false,
  }) {
    final actions = [
      if (picked)
        BottomSheetAction('Rimuovi',
            icon: FontAwesomeIcons.trash,
            backgroundColor: Colors.red, onTap: () {
          context.read<ImagePickerBloc>().reset();

          Navigator.of(context).pop();
        }),
      BottomSheetAction(
        'Galleria',
        icon: FontAwesomeIcons.fileImage,
        backgroundColor: Colors.blue,
        onTap: () {
          context.read<ImagePickerBloc>().pickGalleryImage();

          Navigator.of(context).pop();
        },
      ),
      BottomSheetAction(
        'Fotocamera',
        icon: FontAwesomeIcons.camera,
        backgroundColor: Colors.orange,
        onTap: () {
          context.read<ImagePickerBloc>().pickCameraImage();

          Navigator.of(context).pop();
        },
      ),
    ];

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 160.0,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Immagine del profilo',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                scrollDirection: Axis.horizontal,
                itemCount: actions.length,
                itemBuilder: (context, index) => actions[index],
                separatorBuilder: (_, __) => Container(width: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        child: TextFormField(
          controller: _signUpNameController,
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
            errorStyle: TextStyle(
              fontSize: 10,
              height: 0.1,
            ),
            icon: Icon(
              FontAwesomeIcons.user,
              color: Colors.black,
              size: 22.0,
            ),
          ),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Nome troppo corto';
            }
          },
          onFieldSubmitted: (_) {
            _focusNodeEmail.requestFocus();
          },
        ),
      );

  Widget _emailField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextFormField(
          controller: _signUpEmailController,
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

  Widget _passwordField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextFormField(
          controller: _signUpPasswordController,
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
            errorStyle: const TextStyle(
              fontSize: 10,
              height: 0.1,
            ),
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
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password troppo corta';
            }
          },
          onFieldSubmitted: (_) {
            _focusNodeConfirmPassword.requestFocus();
          },
        ),
      );

  Widget _confirmPasswordField() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: TextFormField(
          controller: _signUpConfirmPasswordController,
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
            errorStyle: const TextStyle(
              fontSize: 10,
              height: 0.1,
            ),
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
          validator: (value) {
            if (_signUpPasswordController.text != value) {
              return 'Le password non corrispondono';
            }
          },
          onFieldSubmitted: (_) {
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
            onPressed: _formValid ? () {} : null,
          ),
        ),
      );
}

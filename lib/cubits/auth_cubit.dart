import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthCubit extends HydratedCubit<bool> {

  AuthCubit() : super(false);

  void authenticate(String password) => emit(password == 'Password123');

  @override
  bool? fromJson(Map<String, dynamic> json) => json['authenticated'] as bool;

  @override
  Map<String, dynamic>? toJson(bool state) => {'authenticated': state};

}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_network/models/sign_in_request.dart';
import 'package:social_network/models/sign_up_request.dart';
import 'package:social_network/models/user.dart';

class AuthService {
  Future<User> signIn(SignInRequest request) async {
    final response = await http.post(
      Uri.parse('https://servatedb.vercel.app/api/fudeo-flutter-2-focus/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception('Errore nel sign in');
  }

  Future<User> signUp(SignUpRequest request) async {
    final response = await http.post(
      Uri.parse(
          'https://servatedb.vercel.app/api/fudeo-flutter-2-focus/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception('Errore nel sign up');
  }
}

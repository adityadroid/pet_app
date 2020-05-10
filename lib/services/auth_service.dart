import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_app/config/constants.dart';
import 'package:pet_app/models/login_response.dart';

class AuthService {
  Future<LoginResponse> signIn(String email, String password) async {
    final response = await http
        .post(LOGIN_API, body: {'username': email, 'password': password});
    if (response.statusCode > 200) {
      return null;
    }
    final result = LoginResponse.fromJson(jsonDecode(response.body));
    return result;
  }
}

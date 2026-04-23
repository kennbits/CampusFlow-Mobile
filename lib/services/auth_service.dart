import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loginKey = 'is_logged_in';
  static const String _userKey = 'username';

  static const String baseUrl =
      'http://127.0.0.1:8000/api';

  Future<bool> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {
              'Accept': 'application/json',
            },
            body: {
              'email': username.trim(),
              'password': password.trim(),
            },
          )
          .timeout(
            const Duration(seconds: 10),
          );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final prefs =
            await SharedPreferences
                .getInstance();

        await prefs.setBool(
            _loginKey, true);

        await prefs.setString(
          _userKey,
          data['name'] ?? username,
        );

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getBool(
            _loginKey) ??
        false;
  }

  Future<String> getUsername() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
            _userKey) ??
        '';
  }
}
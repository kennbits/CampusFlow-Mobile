import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      'http://172.16.150.140:8000/api';

  static const String loginKey =
      'is_logged_in';

  static const String userKey =
      'username';

  static const String emailKey =
      'email';

  static const String roleKey =
      'role';

  static const String tokenKey =
      'token';

  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode != 200) {
        return false;
      }

      final data =
          jsonDecode(response.body);

      final prefs =
          await SharedPreferences
              .getInstance();

      await prefs.setBool(
        loginKey,
        true,
      );

      await prefs.setString(
        userKey,
        data['name'] ?? '',
      );

      await prefs.setString(
        emailKey,
        data['email'] ?? '',
      );

      await prefs.setString(
        roleKey,
        data['role']['name'] ?? '',
      );

      await prefs.setString(
        tokenKey,
        data['token'] ?? '',
      );

      return true;
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
          loginKey,
        ) ??
        false;
  }

  Future<String> getUsername() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          userKey,
        ) ??
        '';
  }

  Future<String> getEmail() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          emailKey,
        ) ??
        '';
  }

  Future<String> getRole() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          roleKey,
        ) ??
        '';
  }

  Future<String> getToken() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          tokenKey,
        ) ??
        '';
  }
}
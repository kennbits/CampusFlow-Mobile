// lib/services/auth_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loginKey = 'is_logged_in';
  static const String _userKey = 'username';

  // local test accounts
  final Map<String, String> users = {
    'admin': '123456',
    'staff': '123456',
    'user': '123456',
  };

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (users.containsKey(username) && users[username] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginKey, true);
      await prefs.setString(_userKey, username);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey) ?? '';
  }
}
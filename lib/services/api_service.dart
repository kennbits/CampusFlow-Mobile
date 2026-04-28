import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  // localhost for same PC testing
  static const String baseUrl = 'http://172.16.150.140:8000/api';

  // status
  static Future<dynamic> getStatus() async {
    final response = await http.get(Uri.parse('$baseUrl/status'));
    return jsonDecode(response.body);
  }

  // alerts
  static Future<dynamic> getAlerts() async {
    final response = await http.get(Uri.parse('$baseUrl/alerts'));
    return jsonDecode(response.body);
  }

  // history
  static Future<dynamic> getHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/history'));
    return jsonDecode(response.body);
  }

  // readings
  static Future<dynamic> getReadings() async {
    final response = await http.get(Uri.parse('$baseUrl/readings'));
    return jsonDecode(response.body);
  }

  // login
  static Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    return jsonDecode(response.body);
  }

  // profile
  static Future<dynamic> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
    );

    return jsonDecode(response.body);
  }

  // store reading
  static Future<dynamic> storeReading({
    required String module,
    required String sourceName,
    required String reading,
    required String remarks,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/readings'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'module': module,
        'source_name': sourceName,
        'reading': reading,
        'remarks': remarks,
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed');
  }

  static Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token =
        await AuthService().getToken();

    final response = await http.put(
      Uri.parse(
        '$baseUrl/change-password',
      ),
      headers: {
        'Accept':
            'application/json',
        'Authorization':
            'Bearer $token',
      },
      body: {
        'current_password':
            currentPassword,
        'new_password':
            newPassword,
        'confirm_password':
            confirmPassword,
      },
    );

    return jsonDecode(response.body);
  }
}
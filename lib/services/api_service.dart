import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // localhost for same PC testing
  static const String baseUrl = 'http://localhost:8000/api';

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
}
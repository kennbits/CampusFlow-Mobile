import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'offline_queue_service.dart';

import '../models/pending_reading.dart';
import '../models/resource_meter.dart';

class ApiService {
  // localhost for same PC testing
  static const String baseUrl = 'http://172.16.150.140:8000/api';

  // resource meters
  static Future<List<ResourceMeter>>
  getResourceMeters(String type) async {

    final response = await http.get(
      Uri.parse(
        '$baseUrl/resource-meters?type=$type',
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      return [];
    }

    final data = jsonDecode(response.body);

    return List<ResourceMeter>.from(
      data.map(
        (x) => ResourceMeter.fromJson(x),
      ),
    );
  }

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
    required int meterId,
    required String reading,
  }) async {

    try {

      final token =
          await AuthService().getToken();

      final response = await http.post(

        Uri.parse('$baseUrl/readings'),

        headers: {

          'Accept':
              'application/json',

          'Authorization':
              'Bearer $token',
        },

        body: {

          'resource_meter_id':
              meterId.toString(),

          'reading':
              reading,
        },
      );

      print(response.statusCode);

      print(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        return jsonDecode(
          response.body,
        );
      }

      throw Exception(
        response.body,
      );

    } catch (e) {

      // Save offline if API fails
      await OfflineQueueService()
          .saveReading(

        PendingReading(

          meterId: meterId,

          reading: reading,
        ),
      );

      return {

        'offline': true,

        'message':
            'Saved offline. Will sync later.',
      };
    }
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
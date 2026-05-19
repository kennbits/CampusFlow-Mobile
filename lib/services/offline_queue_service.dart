import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

import '../models/pending_reading.dart';

class OfflineQueueService {

  static const String key =
      'pending_readings';

  Future<void> saveReading(
    PendingReading reading,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final existing =
        prefs.getStringList(key) ?? [];

    existing.add(
      jsonEncode(
        reading.toJson(),
      ),
    );

    await prefs.setStringList(
      key,
      existing,
    );
  }

  Future<List<PendingReading>>
  getPendingReadings() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final data =
        prefs.getStringList(key) ?? [];

    return data.map((item) {

      return PendingReading.fromJson(
        jsonDecode(item),
      );

    }).toList();
  }

  Future<void> clearQueue() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.remove(key);
  }

  Future<void> syncPendingReadings()
  async {

    final pending =
        await getPendingReadings();

    if (pending.isEmpty) {
      return;
    }

    final successful = <PendingReading>[];

    for (final reading in pending) {

      try {

        final result =
            await ApiService
                .storeReading(

          meterId:
              reading.meterId,

          reading:
              reading.reading,
        );

        // Skip offline result
        if (result['offline'] == true) {
          continue;
        }

        successful.add(
          reading,
        );

      } catch (_) {}
    }

    // Remove successfully synced
    final remaining =
        pending.where(

      (item) =>
          !successful.contains(item),

    ).toList();

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setStringList(

      key,

      remaining.map((item) {

        return jsonEncode(
          item.toJson(),
        );

      }).toList(),
    );
  }
}
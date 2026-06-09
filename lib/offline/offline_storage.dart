import 'package:hive/hive.dart';

class OfflineStorage {
  static final Box sosBox = Hive.box('sosBox');

  static Future<void> saveSOS({
    required String type,
    required double latitude,
    required double longitude,
  }) async {
    await sosBox.add({
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'time': DateTime.now().toString(),
      'synced': false,
    });
  }

  static Future<void> saveSOSRequest(
    Map<String, dynamic> sos,
  ) async {
    sos['synced'] ??= false;

    await sosBox.add(sos);
  }

  static List getSOSList() {
    return sosBox.values.toList();
  }

  static List getAllSOS() {
    return sosBox.values.toList();
  }

  static Future<void> markAsSynced(
    int index,
  ) async {
    final sos = Map<String, dynamic>.from(
      sosBox.getAt(index),
    );

    sos['synced'] = true;
    sos['syncedAt'] = DateTime.now().toIso8601String();

    await sosBox.putAt(index, sos);
  }
}

import './api_service.dart';
import 'dart:convert';

class SOSApiService {
  static Future<String?> createSOS({
    required String citizenId,
    required String type,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await ApiService.post(
        '/sos',
        {
          "citizenId": citizenId,
          "citizenName": "Citizen User",
          "phoneNumber": "",
          "emergencyType": type,
          "description": "",
          "latitude": latitude,
          "longitude": longitude,
        },
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return json["data"]["_id"];
      }

      return null;
    } catch (e) {
      print("API ERROR: $e");
      return null;
    }
  }
}

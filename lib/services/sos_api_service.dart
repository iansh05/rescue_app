import './api_service.dart';

class SOSApiService {
  static Future<bool> createSOS({
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

      return response.statusCode == 201;
    } catch (e) {
      print("API ERROR: $e");
      return false;
    }
  }
}

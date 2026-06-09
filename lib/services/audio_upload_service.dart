import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AudioUploadService {
  Future<String?> uploadAudio(
    String sosId,
    String audioPath,
  ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${ApiConfig.baseUrl}/api/sos/$sosId/audio',
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'audio',
          audioPath,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        final jsonData = json.decode(body);

        return jsonData['audioUrl'];
      }

      return null;
    } catch (e) {
      print("Audio Upload Error: $e");
      return null;
    }
  }
}

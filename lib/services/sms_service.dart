import 'package:url_launcher/url_launcher.dart';

class SMSService {
  Future<void> sendMessage({
    required String phone,
    required String message,
  }) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: {
        'body': message,
      },
    );

    await launchUrl(
      smsUri,
    );
  }
}

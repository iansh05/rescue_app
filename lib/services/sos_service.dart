import '../services/location_service.dart';
import '../models/sos_request.dart';
import '../offline/offline_storage.dart';
import 'package:uuid/uuid.dart';
import 'contact_service.dart';
import 'sms_service.dart';

class SOSService {
  Future<void> triggerSOS(String type) async {
    try {
      print("TRIGGER SOS CALLED");

      final locationService = LocationService();

      final position = await locationService.getCurrentLocation();

      print(
        "Latitude: ${position.latitude}",
      );

      print(
        "Longitude: ${position.longitude}",
      );

      final sos = SOSRequest(
        id: const Uuid().v4(),
        type: type,
        latitude: position.latitude,
        longitude: position.longitude,
        status: "pending",
        timestamp: DateTime.now(),
      );

      await OfflineStorage.saveSOSRequest(
        sos.toMap(),
      );

      print("SOS SAVED");

      final contacts = ContactService.getContacts();

      print(
        "CONTACTS FOUND: ${contacts.length}",
      );

      final message = '''
EMERGENCY SOS

Location:
https://maps.google.com/?q=${position.latitude},${position.longitude}

Need help immediately.
''';

      final smsService = SMSService();

      for (final contact in contacts) {
        print(
          "Sending SMS to ${contact['phone']}",
        );

        await smsService.sendMessage(
          phone: contact['phone'],
          message: message,
        );
      }

      print("ALL SMS SENT");

      print(
        OfflineStorage.getAllSOS(),
      );
    } catch (e) {
      print(
        "SOS ERROR: $e",
      );
    }
  }
}

import '../offline/offline_storage.dart';
import 'sos_api_service.dart';
import '../constants/sos_status.dart';

class SyncService {
  static Future<void> syncPendingSOS() async {
    final sosList = OfflineStorage.getSOSList();

    for (int i = 0; i < sosList.length; i++) {
      final sos = sosList[i];

      if (sos['synced'] != true) {
        print("SYNCING SOS: $sos");

        try {
          final backendSosId = await SOSApiService.createSOS(
            citizenId: sos['id']?.toString() ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            type: sos['type']?.toString() ?? "Emergency",
            latitude: (sos['latitude'] ?? 0).toDouble(),
            longitude: (sos['longitude'] ?? 0).toDouble(),
          );

          if (backendSosId != null) {
            await OfflineStorage.markAsSynced(i);

            print(
              "SOS SYNCED SUCCESSFULLY",
            );
          } else {
            print(
              "SYNC FAILED",
            );
          }
        } catch (e) {
          print(
            "SYNC ERROR: $e",
          );
        }
      }
    }

    print("SYNC COMPLETE");
  }
}

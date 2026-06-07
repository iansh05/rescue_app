import '../offline/offline_storage.dart';
import 'sos_api_service.dart';

class SyncService {
  static Future<void> syncPendingSOS() async {
    final sosList = OfflineStorage.getSOSList();

    for (int i = 0; i < sosList.length; i++) {
      final sos = sosList[i];

      if (sos['synced'] == false || sos['status'] == 'pending') {
        print("SYNCING SOS: $sos");

        try {
          final success = await SOSApiService.createSOS(
            citizenId: sos['id']?.toString() ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            type: sos['type']?.toString() ?? "Emergency",
            latitude: (sos['latitude'] ?? 0).toDouble(),
            longitude: (sos['longitude'] ?? 0).toDouble(),
          );

          if (success) {
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

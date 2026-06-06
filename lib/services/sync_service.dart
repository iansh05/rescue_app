import '../offline/offline_storage.dart';

class SyncService {
  static Future<void> syncPendingSOS() async {
    final sosList = OfflineStorage.getSOSList();

    for (int i = 0; i < sosList.length; i++) {
      final sos = sosList[i];

      if (sos['synced'] == false || sos['status'] == 'pending') {
        print("SYNCING SOS: $sos");

        sos['synced'] = true;
      }
    }

    print("SYNC COMPLETE");
  }
}

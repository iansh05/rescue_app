import '../../offline/offline_storage.dart';
import '../models/authority_sos.dart';

class AuthorityService {
  Future<List<AuthoritySOS>> fetchSOS() async {
    final records = OfflineStorage.getAllSOS();

    return records.map<AuthoritySOS>((item) {
      return AuthoritySOS(
        id: item['id'] ?? '',
        userName: 'Citizen User',
        emergencyType: item['type'] ?? 'Unknown',
        latitude: item['latitude'] ?? 0.0,
        longitude: item['longitude'] ?? 0.0,
        timestamp: DateTime.tryParse(
              item['timestamp']?.toString() ?? item['time']?.toString() ?? '',
            ) ??
            DateTime.now(),
        status: item['status'] ?? 'Pending',
      );
    }).toList();
  }

  Future<void> acceptSOS(AuthoritySOS sos) async {
    sos.status = "Accepted";
  }

  Future<void> resolveSOS(AuthoritySOS sos) async {
    sos.status = "Resolved";
  }
}

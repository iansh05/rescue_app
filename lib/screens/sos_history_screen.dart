import 'package:flutter/material.dart';
import '../offline/offline_storage.dart';

class SOSHistoryScreen extends StatelessWidget {
  const SOSHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sosList = OfflineStorage.getAllSOS();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS History"),
      ),
      body: ListView.builder(
        itemCount: sosList.length,
        itemBuilder: (context, index) {
          final sos = sosList[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: Icon(
                Icons.warning,
                color: sos['synced'] == true ? Colors.green : Colors.orange,
              ),
              title: Text(
                sos['type'] ?? 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Time: ${sos['time'] ?? sos['timestamp'] ?? ''}\n"
                "Latitude: ${sos['latitude'] ?? 'N/A'}\n"
                "Longitude: ${sos['longitude'] ?? 'N/A'}",
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: sos['synced'] == true
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  sos['synced'] == true ? "Synced" : "Pending",
                  style: TextStyle(
                    color: sos['synced'] == true
                        ? Colors.green.shade800
                        : Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

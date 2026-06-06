import 'package:flutter/material.dart';
import '../models/authority_sos.dart';

class SOSDetailScreen extends StatefulWidget {
  final AuthoritySOS sos;

  const SOSDetailScreen({
    super.key,
    required this.sos,
  });

  @override
  State<SOSDetailScreen> createState() => _SOSDetailScreenState();
}

class _SOSDetailScreenState extends State<SOSDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final sos = widget.sos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SOS Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sos.userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text("Emergency: ${sos.emergencyType}"),
            Text("Latitude: ${sos.latitude}"),
            Text("Longitude: ${sos.longitude}"),
            Text("Status: ${sos.status}"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sos.status = "Accepted";
                });
              },
              child: const Text("Accept SOS"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sos.status = "Resolved";
                });
              },
              child: const Text("Resolve SOS"),
            ),
          ],
        ),
      ),
    );
  }
}

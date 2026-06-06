import 'package:flutter/material.dart';

import '../models/authority_sos.dart';
import '../services/authority_service.dart';
import 'sos_detail_screen.dart';

class AuthorityDashboardScreen extends StatefulWidget {
  const AuthorityDashboardScreen({super.key});

  @override
  State<AuthorityDashboardScreen> createState() =>
      _AuthorityDashboardScreenState();
}

class _AuthorityDashboardScreenState extends State<AuthorityDashboardScreen> {
  final AuthorityService service = AuthorityService();

  List<AuthoritySOS> sosList = [];

  @override
  void initState() {
    super.initState();
    loadSOS();
  }

  Future<void> loadSOS() async {
    sosList = await service.fetchSOS();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authority Dashboard"),
      ),
      body: ListView.builder(
        itemCount: sosList.length,
        itemBuilder: (context, index) {
          final sos = sosList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SOSDetailScreen(
                    sos: sos,
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sos.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Type: ${sos.emergencyType}"),
                    Text("Status: ${sos.status}"),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await service.acceptSOS(sos);
                            setState(() {});
                          },
                          child: const Text("Accept"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await service.resolveSOS(sos);
                            setState(() {});
                          },
                          child: const Text("Resolve"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

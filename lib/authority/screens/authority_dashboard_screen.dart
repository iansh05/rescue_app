import 'package:flutter/material.dart';

import '../models/authority_sos.dart';
import '../services/authority_service.dart';
import 'sos_detail_screen.dart';
import '../services/mock_sos_data.dart';

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

  if (sosList.isEmpty) {
    sosList = mockSOS;
  }

  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  title: const Text("Authority Dashboard"),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ],
),
      body: sosList.isEmpty
    ? const Center(
        child: Text(
          "No SOS Requests",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      )
    : Column(
    children: [

      Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A1115),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFE52E3D),
            ),
            const SizedBox(width: 10),
            Text(
              "${sosList.length} Active SOS Alerts",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF18181C),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Color(0xFFE52E3D),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${sosList.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Active",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF18181C),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Resolved",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 15),

      Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12),
  child: TextField(
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: "Search SOS Requests",
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      filled: true,
      fillColor: const Color(0xFF18181C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  ),
),

const SizedBox(height: 15),

      Expanded(
        child: ListView.builder(
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
            child: Container(
  margin: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: const Color(0xFF18181C),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
      color: const Color(0xFFE52E3D).withOpacity(0.2),
    ),
  ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
  children: [
    Expanded(
      child: Text(
        sos.userName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
    Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "HIGH PRIORITY",
        style: TextStyle(
          color: Color(0xFFE52E3D),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  ],
),

const SizedBox(height: 12),

Text(
  "🚨 Emergency: ${sos.emergencyType}",
  style: const TextStyle(
    color: Colors.white,
    fontSize: 15,
  ),
),

const SizedBox(height: 6),

Text(
  "📡 Status: ${sos.status}",
  style: const TextStyle(
    color: Colors.white70,
  ),
),

const SizedBox(height: 6),

Text(
  "📍 Location: ${sos.latitude}, ${sos.longitude}",
  style: const TextStyle(
    color: Colors.white70,
  ),
),

const SizedBox(height: 6),

Text(
  "🕒 ${sos.timestamp}",
  style: const TextStyle(
    color: Colors.white70,
  ),
),

const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await service.acceptSOS(sos);
                            setState(() {});
                          },
                          child: const Text("Dispatch"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await service.resolveSOS(sos);
                            setState(() {});
                          },
                          child: const Text("Mark Resolved"),
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
      ),
    ],
  ),
);
  }
}

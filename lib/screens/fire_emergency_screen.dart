import 'package:flutter/material.dart';

class FireEmergencyScreen extends StatelessWidget {
  const FireEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Fire Emergency", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Dispatch & Safety Guides", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      const Spacer(),
                      const Icon(Icons.local_fire_department, color: Colors.redAccent),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ping Container
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1111),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(children: [Icon(Icons.emergency_share, color: Colors.redAccent), SizedBox(width: 8), Text("FIRE DEPARTMENT PING", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))]),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  _buildLocationBox("Location", "MG Road, Bengaluru"),
                                  const SizedBox(width: 10),
                                  _buildLocationBox("Nearest Station", "Station No. 4 · 1.1 km"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                  onPressed: () {},
                                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.local_fire_department, color: Colors.white), SizedBox(width: 8), Text("PING FIRE DEPARTMENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("SAFETY GUIDES", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                        const SizedBox(height: 15),
                        _buildGuideItem(Icons.air, "Smoke Inhalation First Aid"),
                        _buildGuideItem(Icons.arrow_forward, "Fire Escape Protocol"),
                        _buildGuideItem(Icons.thumb_up_alt_outlined, "Home Fire Prevention"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationBox(String title, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF221616), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis),
      ]),
    ),
  );

  Widget _buildGuideItem(IconData icon, String title) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Icon(icon, color: Colors.redAccent),
      const SizedBox(width: 15),
      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      const Spacer(),
      const Icon(Icons.menu_book, color: Colors.grey, size: 18),
      const SizedBox(width: 10),
      const Icon(Icons.chevron_right, color: Colors.grey),
    ]),
  );
}
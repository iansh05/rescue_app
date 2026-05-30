import 'package:flutter/material.dart';
import 'women_safety_screen.dart';
import 'fire_emergency_screen.dart';
import 'ambulance_screen.dart';
import 'natural_calamity_screen.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Emergency Services", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text("Select a category to access tools", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF1C1215), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Color(0xFFE52E3D), size: 16),
                    const SizedBox(width: 8),
                    const Text("1 active alert in your area · ", style: TextStyle(fontSize: 12, color: Colors.white)),
                    const Text("Cyclone warning in effect", style: TextStyle(color: Color(0xFFE52E3D), fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.78,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WomenSafetyScreen())),
                      child: _buildEmergencyCard(
                        "Women Safety",
                        "Fake call & companion tracking",
                        Icons.favorite_border,
                        Colors.purpleAccent,
                        ["Fake incoming call", "Live companion tracking", "Discreet SOS"],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NaturalCalamityScreen())),
                      child: _buildEmergencyCard(
                        "Natural Calamity",
                        "Alerts, routes & survival",
                        Icons.thunderstorm_outlined,
                        Colors.orangeAccent,
                        ["Live weather alerts", "Evacuation routes", "Survival checklist"],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceScreen())),
                      child: _buildEmergencyCard(
                        "Ambulance Support",
                        "Medical dispatch & blood bank",
                        Icons.add_box_outlined,
                        Colors.greenAccent,
                        ["One-tap dispatch", "Blood bank finder", "Medical ID share"],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FireEmergencyScreen())),
                      child: _buildEmergencyCard(
                        "Fire Emergency",
                        "Fire dept ping & safety guides",
                        Icons.local_fire_department_outlined,
                        Colors.redAccent,
                        ["Instant fire dept ping", "Escape protocol", "Smoke safety guide"],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text("QUICK DIAL", style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDialItem("101", "FIRE", Colors.redAccent),
                  _buildDialItem("108", "AMBULANCE", Colors.greenAccent),
                  _buildDialItem("1091", "WOMEN", Colors.purpleAccent),
                  _buildDialItem("112", "NATIONAL", Colors.orangeAccent),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(String title, String subtitle, IconData icon, Color color, List<String> points) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
          const SizedBox(height: 10),
          ...points.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 4, color: color),
                    const SizedBox(width: 6),
                    Expanded(child: Text(p, style: const TextStyle(color: Colors.grey, fontSize: 10), overflow: TextOverflow.ellipsis)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDialItem(String number, String label, Color color) {
    return Container(
      width: 76,
      height: 65,
      decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 8, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
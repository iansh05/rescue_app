import 'package:flutter/material.dart';

class NaturalCalamityScreen extends StatelessWidget {
  const NaturalCalamityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar removed to allow custom header placement
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            children: [
              // Custom Header
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 16),
              const Text("Natural Calamity", 
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // 1. High Alert Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D1F0E), 
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.thermostat, color: Colors.orange, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Coastal Zone · High Alert", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("Humidity 88% · Pressure dropping", style: TextStyle(color: Colors.grey[400], fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.circle, color: Colors.red, size: 8),
                    const SizedBox(width: 4),
                    const Text("LIVE", style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // 2. Section Headers & Tiles
              _buildSectionHeader("ACTIVE WEATHER ALERTS"),
              _buildAlertTile("Cyclone Warning", "Cyclone Biparjoy · 180 km/h", "HIGH", Colors.red),
              _buildAlertTile("Flash Flood Watch", "River basin region · 6–12 hr", "MED", Colors.orange),

              const SizedBox(height: 20),
              _buildSectionHeader("EVACUATION ROUTES"),
              _buildRouteTile("Evacuation Route A", "Central Stadium · 3.2 km", "SAFE", Colors.green),
              _buildRouteTile("Coastal Highway", "Inland Shelter · 8.5 km", "AVOID", Colors.red),
              
              const SizedBox(height: 10),
              // Checklist Button
              Card(
                color: const Color(0xFF111114),
                child: ListTile(
                  leading: const Icon(Icons.checklist, color: Colors.orange),
                  title: const Text("SURVIVAL CHECKLIST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  trailing: const Text("0/8 >", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
  );

  Widget _buildAlertTile(String title, String subtitle, String tag, Color color) {
    return Card(
      color: const Color(0xFF111114),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        leading: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)), child: Text(tag, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9))),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
        trailing: Icon(Icons.error_outline, color: color, size: 18),
      ),
    );
  }

  Widget _buildRouteTile(String name, String sub, String status, Color color) {
    return Card(
      color: const Color(0xFF111114),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        leading: Icon(Icons.near_me, color: color, size: 20),
        title: Text(name, style: const TextStyle(color: Colors.white, fontSize: 14)),
        subtitle: Text("→ $sub", style: TextStyle(color: Colors.grey[600], fontSize: 11)),
        trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(status, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
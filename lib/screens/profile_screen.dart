import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF1C1113), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 24, backgroundColor: Color(0xFFE52E3D), child: Text("P", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Priya Sharma", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 2),
                        Text("+91 98123 45678", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        const SizedBox(height: 4),
                        const Text("• Protected · Premium", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildSettingRow(Icons.security, "Safe Mode", "Auto-alert if check-in missed", trailing: Switch(value: true, onChanged: (v) {}, activeColor: const Color(0xFFE52E3D))),
                    _buildSettingRow(Icons.notifications_none, "Notifications", "Check-in reminders, alerts"),
                    _buildSettingRow(Icons.location_on_outlined, "Location Privacy", "Who sees your location"),
                    _buildSettingRow(Icons.chat_bubble_outline, "Auto Message", "Sent on SOS trigger"),
                    _buildSettingRow(Icons.mic_none_outlined, "Audio Recording", "Background audio on SOS"),
                    _buildSettingRow(Icons.settings_outlined, "App Settings", "Theme, language, data"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: const Color(0xFF140F10), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF331619))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xFFE52E3D), size: 18),
                    SizedBox(width: 8),
                    Text("Sign Out", style: TextStyle(color: Color(0xFFE52E3D), fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow(IconData icon, String title, String subtitle, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFE52E3D), size: 20),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              ],
            ),
            const Spacer(),
            trailing ?? Icon(Icons.arrow_forward_ios, color: Colors.grey[850], size: 14),
          ],
        ),
      ),
    );
  }
}
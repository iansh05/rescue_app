import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;

  const ProfileScreen({
    super.key,
    required this.userName,
  });
  void _showAppSettings(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111114),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "App Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                ),
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.light_mode,
                  color: Colors.white,
                ),
                title: const Text(
                  "Light Mode",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                title: const Text(
                  "English",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                title: const Text(
                  "हिन्दी",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(), // Adds that premium bounce feel
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Profile",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 20),

              // Profile Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xFF1C1113),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFFE52E3D),
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : "U",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 4),
                        Text("+91 98123 45678",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12)),
                        const SizedBox(height: 4),
                        const Text("• Protected · Premium",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Settings List (No ListView or Expanded needed here)
              _buildSettingRow(
                  Icons.security, "Safe Mode", "Auto-alert if check-in missed",
                  trailing: Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: const Color(0xFFE52E3D))),
              _buildSettingRow(Icons.notifications_none, "Notifications",
                  "Check-in reminders, alerts"),
              _buildSettingRow(Icons.location_on_outlined, "Location Privacy",
                  "Who sees your location"),
              _buildSettingRow(Icons.chat_bubble_outline, "Auto Message",
                  "Sent on SOS trigger"),
              _buildSettingRow(Icons.mic_none_outlined, "Audio Recording",
                  "Background audio on SOS"),
              GestureDetector(
                onTap: () {
                  _showAppSettings(context);
                },
                child: _buildSettingRow(
                  Icons.settings_outlined,
                  "App Settings",
                  "Theme, language, data",
                ),
              ),

              const SizedBox(height: 32),

              // Sign Out Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFF140F10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF331619))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xFFE52E3D), size: 20),
                    SizedBox(width: 8),
                    Text("Sign Out",
                        style: TextStyle(
                            color: Color(0xFFE52E3D),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow(IconData icon, String title, String subtitle,
      {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xFF111114),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFE52E3D), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                ],
              ),
            ),
            trailing ??
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.white24, size: 14),
          ],
        ),
      ),
    );
  }
}

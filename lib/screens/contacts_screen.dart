import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Emergency Contacts", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text("3 contacts will be alerted on SOS", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFE52E3D), shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 24),
              _buildContactCard("Anjali Mehta", "Sister · +91 98765 43210", Colors.purple, "A"),
              const SizedBox(height: 12),
              _buildContactCard("Rahul Sharma", "Father · +91 87654 32109", Colors.blue, "R"),
              const SizedBox(height: 12),
              _buildContactCard("Dr. Kavita Nair", "Trusted Friend · +91 76543 21098", Colors.orange, "K"),
              const SizedBox(height: 24),
              Text("EMERGENCY HELPLINES", style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildHelplineRow("National Emergency", "112"),
                    _buildHelplineRow("Women Helpline", "1091"),
                    _buildHelplineRow("Police", "100"),
                    _buildHelplineRow("Ambulance", "108"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String relation, Color avatarColor, String initial) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: avatarColor, radius: 22, child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
              const SizedBox(height: 2),
              Text(relation, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.phone_outlined, color: Color(0xFFE52E3D), size: 20)
        ],
      ),
    );
  }

  Widget _buildHelplineRow(String title, String dispatchNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFE52E3D), size: 18),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
            const Spacer(),
            Text(dispatchNumber, style: const TextStyle(color: Color(0xFFE52E3D), fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[800], size: 12),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AmbulanceSupportScreen extends StatelessWidget {
  const AmbulanceSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      // Center the content and constrain it to a maximum width of 480 (typical mobile width)
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SafeArea(
            child: Column(
              children: [
                // Header remains the same
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Ambulance Support", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Dispatch & Blood Bank Finder", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      const Spacer(),
                      const Icon(Icons.add_circle_outline, color: Colors.greenAccent),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: const Color(0xFF0F1A10), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.greenAccent.withOpacity(0.2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(children: [Icon(Icons.local_shipping, color: Colors.greenAccent), SizedBox(width: 8), Text("ONE-TAP MEDICAL DISPATCH", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))]),
                              const SizedBox(height: 10),
                              const Text("Instantly alert nearest ambulance with your GPS location and medical ID.", style: TextStyle(color: Colors.white70, fontSize: 13)),
                              const SizedBox(height: 20),
                              // Spaced Row
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ["Cardiac", "Trauma", "Respiratory"].map((e) => _buildChip(e)).toList()),
                              const SizedBox(height: 20),
                              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () {}, child: const Text("DISPATCH AMBULANCE NOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text("BLOOD BANK FINDER", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                        const SizedBox(height: 15),
                        Wrap(spacing: 8, runSpacing: 8, children: ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"].map((e) => _buildBloodTypeChip(e, e == "A+")).toList()),
                        const SizedBox(height: 20),
                        _buildResultCard("Apollo Blood Bank", "1.2 km away", "OPEN", ["A+", "O+", "B-"]),
                        _buildResultCard("City General Hospital", "2.8 km away", "OPEN", ["A-", "AB+", "O-"]),
                        _buildResultCard("Red Cross Centre", "4.1 km away", "CLOSED", ["A+", "B+", "O+", "AB-"]),
                        const SizedBox(height: 20), // Bottom padding
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

  Widget _buildChip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
  );

  Widget _buildBloodTypeChip(String label, bool isRed) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(color: isRed ? Colors.redAccent : const Color(0xFF222222), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
  );

  Widget _buildResultCard(String title, String dist, String status, List<String> types) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.water_drop, color: Colors.redAccent, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const Spacer(),
        Text(status, style: TextStyle(color: status == "OPEN" ? Colors.greenAccent : Colors.grey, fontWeight: FontWeight.bold, fontSize: 12))
      ]),
      Padding(padding: const EdgeInsets.only(left: 28), child: Text(dist, style: const TextStyle(color: Colors.grey, fontSize: 12))),
      const SizedBox(height: 12),
      Padding(padding: const EdgeInsets.only(left: 28), child: Wrap(spacing: 8, children: types.map((e) => _buildBloodTypeChip(e, false)).toList())),
    ]),
  );
}
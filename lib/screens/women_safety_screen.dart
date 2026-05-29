import 'package:flutter/material.dart';

class WomenSafetyScreen extends StatelessWidget {
  const WomenSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Space for status bar
                
                // NEW HEADER POSITION
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 16),
                const Text("Women Safety", 
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("Protection & Companion Features", 
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 24),

                // FAKE CALL CONTAINER (Rest of your code remains identical)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161618),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Icon(Icons.call, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Text("FAKE CALL", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1))
                      ]),
                      const SizedBox(height: 10),
                      const Text("Simulate an incoming call to escape uncomfortable situations discreetly.", 
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ["Mom", "Office", "Unknown"].map((text) => _buildSelectionButton(text)).toList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple, 
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        onPressed: () {},
                        child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.call, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Trigger Fake Call", style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // TRACKING HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Icon(Icons.location_on, color: Colors.purple, size: 20),
                      SizedBox(width: 8),
                      Text("LIVE COMPANION TRACKING", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1))
                    ]),
                    Switch(value: true, onChanged: (val) {}, activeColor: Colors.purple),
                  ],
                ),
                const SizedBox(height: 10),
                
                // TRACKING LIST
                Expanded(
                  child: ListView(
                    children: [
                      _buildContactItem("Anjali Mehta", "0.8 km away", "AM", Colors.green),
                      _buildContactItem("Dr. Kavita Nair", "2.3 km away", "KN", Colors.green),
                      _buildContactItem("Rahul Sharma", "4.1 km away", "RS", Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5))
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildContactItem(String name, String dist, String initials, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF161618), borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.purple, child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        title: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(dist, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: statusColor)),
      ),
    );
  }
}
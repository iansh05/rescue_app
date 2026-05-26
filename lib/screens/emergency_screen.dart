import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Emergency Services",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Icon(Icons.notifications, color: Colors.red),
          SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ALERT BAR
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "1 active alert in your area - Cyclone warning",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GRID CARDS
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,

                children: [

                  emergencyCard(
                    "Women Safety",
                    Icons.favorite,
                    Colors.purple,
                  ),

                  emergencyCard(
                    "Natural Calamity",
                    Icons.cloud,
                    Colors.orange,
                  ),

                  emergencyCard(
                    "Ambulance Support",
                    Icons.local_hospital,
                    Colors.green,
                  ),

                  emergencyCard(
                    "Fire Emergency",
                    Icons.local_fire_department,
                    Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Quick Dial",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  quickDial("101", "FIRE", Icons.local_fire_department),
                  quickDial("108", "AMB", Icons.local_hospital),
                  quickDial("1091", "WOMEN", Icons.woman),
                  quickDial("112", "NATIONAL", Icons.security),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Emergency"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  static Widget emergencyCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.arrow_forward_ios,
                color: color, size: 16),
          )
        ],
      ),
    );
  }

  static Widget quickDial(String number, String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white10,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(number, style: const TextStyle(color: Colors.white)),
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
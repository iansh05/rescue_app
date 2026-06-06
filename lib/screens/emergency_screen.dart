import 'package:flutter/material.dart';
import 'women_safety_screen.dart';
import 'fire_emergency_screen.dart';
import 'ambulance_screen.dart';
import 'natural_calamity_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});
  Future<void> makeCall(String number) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: number,
    );

    await launchUrl(phoneUri);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 360 ? 16 : 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Emergency Services",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Select a category to access tools",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 16),

              // Alert Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1215),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Color(0xFFE52E3D),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "1 active alert in your area · ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "Cyclone warning in effect",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE52E3D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Emergency Categories
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth > 600;

                    return GridView.count(
                      crossAxisCount: isTablet ? 3 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isTablet ? 0.95 : 0.78,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WomenSafetyScreen(),
                            ),
                          ),
                          child: _buildEmergencyCard(
                            "Women Safety",
                            "Fake call & companion tracking",
                            Icons.favorite_border,
                            Colors.purpleAccent,
                            [
                              "Fake incoming call",
                              "Live companion tracking",
                              "Discreet SOS",
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NaturalCalamityScreen(),
                            ),
                          ),
                          child: _buildEmergencyCard(
                            "Natural Calamity",
                            "Alerts, routes & survival",
                            Icons.thunderstorm_outlined,
                            Colors.orangeAccent,
                            [
                              "Live weather alerts",
                              "Evacuation routes",
                              "Survival checklist",
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AmbulanceScreen(),
                            ),
                          ),
                          child: _buildEmergencyCard(
                            "Ambulance Support",
                            "Medical dispatch & blood bank",
                            Icons.add_box_outlined,
                            Colors.greenAccent,
                            [
                              "One-tap dispatch",
                              "Blood bank finder",
                              "Medical ID share",
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FireEmergencyScreen(),
                            ),
                          ),
                          child: _buildEmergencyCard(
                            "Fire Emergency",
                            "Fire dept ping & safety guides",
                            Icons.local_fire_department_outlined,
                            Colors.redAccent,
                            [
                              "Instant fire dept ping",
                              "Escape protocol",
                              "Smoke safety guide",
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "QUICK DIAL",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => makeCall("101"),
                    child: _buildDialItem(
                      "101",
                      "FIRE",
                      Colors.redAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => makeCall("108"),
                    child: _buildDialItem(
                      "108",
                      "AMBULANCE",
                      Colors.greenAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => makeCall("1091"),
                    child: _buildDialItem(
                      "1091",
                      "WOMEN",
                      Colors.purpleAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => makeCall("112"),
                    child: _buildDialItem(
                      "112",
                      "NATIONAL",
                      Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<String> points,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 10),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 4,
                    color: color,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      p,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialItem(
    String number,
    String label,
    Color color,
  ) {
    return Container(
      width: 70,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

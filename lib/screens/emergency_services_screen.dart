import 'package:flutter/material.dart';
import 'fake_call_screen.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // ================= HEADER =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Emergency Services",
                              style: TextStyle(
                                color: Color(0xFFF1F5F9),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Select a category to access tools",
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF141417),
                            border: Border.all(color: const Color(0x44EF233C)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33EF233C),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFFEF233C),
                            size: 22,
                          ),
                        ),
                      ],
                    ),

                    // ================= ALERT BANNER =================
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x1AEF233C),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0x44EF233C)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFEF233C),
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(fontSize: 12.5),
                                children: [
                                  TextSpan(
                                    text: "1 active alert",
                                    style: TextStyle(
                                      color: Color(0xFFEF233C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " in your area · ",
                                    style: TextStyle(color: Color(0xFFF1F5F9)),
                                  ),
                                  TextSpan(
                                    text: "Cyclone warning in effect",
                                    style: TextStyle(
                                      color: Color(0xFFF1F5F9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF233C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ================= GRID =================
                    const SizedBox(height: 20),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Women Safety
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FakeCallScreen(),
                              ),
                            );
                          },
                          child: _buildCard(
                            title: "Women Safety",
                            subtitle: "Fake call & companion tracking",
                            color: const Color(0xFF7C4DFF),
                            icon: Icons.favorite_border_rounded,
                            bullets: const [
                              "Fake incoming call",
                              "Live companion tracking",
                              "Discreet SOS",
                            ],
                          ),
                        ),
                        // Natural Calamity
                        _buildCard(
                          title: "Natural Calamity",
                          subtitle: "Alerts, routes & survival",
                          color: const Color(0xFFFF9800),
                          icon: Icons.cloud_outlined,
                          bullets: const [
                            "Live weather alerts",
                            "Evacuation routes",
                            "Survival checklist",
                          ],
                        ),
                        // Ambulance Support
                        _buildCard(
                          title: "Ambulance Support",
                          subtitle: "Medical dispatch & blood bank",
                          color: const Color(0xFF00C853),
                          icon: Icons.add_circle_outline_rounded,
                          bullets: const [
                            "One-tap dispatch",
                            "Blood bank finder",
                            "Medical ID share",
                          ],
                        ),
                        // Fire Emergency
                        _buildCard(
                          title: "Fire Emergency",
                          subtitle: "Fire dept ping & safety guides",
                          color: const Color(0xFFEF233C),
                          icon: Icons.local_fire_department_outlined,
                          bullets: const [
                            "Instant fire dept ping",
                            "Escape protocol",
                            "Smoke safety guide",
                          ],
                        ),
                      ],
                    ),

                    // ================= QUICK DIAL =================
                    const SizedBox(height: 20),
                    const Text(
                      "QUICK DIAL",
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        letterSpacing: 2,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _dialButton(
                          number: "101",
                          label: "FIRE",
                          color: const Color(0xFFEF233C),
                          icon: Icons.local_fire_department,
                        ),
                        _dialButton(
                          number: "108",
                          label: "AMBULANCE",
                          color: const Color(0xFF00C853),
                          icon: Icons.local_hospital,
                        ),
                        _dialButton(
                          number: "1091",
                          label: "WOMEN",
                          color: const Color(0xFF7C4DFF),
                          icon: Icons.phone_outlined,
                        ),
                        _dialButton(
                          number: "112",
                          label: "NATIONAL",
                          color: const Color(0xFFFF9800),
                          icon: Icons.notifications_active_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= CARD WITH BULLET POINTS =================
  static Widget _buildCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required List<String> bullets,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF111114),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFF1F5F9),
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 11,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.18),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: color,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= QUICK DIAL BUTTON =================
  static Widget _dialButton({
    required String number,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(height: 5),
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
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 9,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV BAR =================
  static Widget _buildBottomNav() {
    return SizedBox(
      height: 64,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0E0E11),
          border: Border(top: BorderSide(color: Color(0xFF1E1E25), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _navItem(icon: Icons.home_outlined, label: "Home", active: false),
            _navItem(icon: Icons.map_outlined, label: "Map", active: false),
            // Centre Emergency button
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF233C),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x55EF233C),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Emergency",
                  style: TextStyle(
                    color: Color(0xFFEF233C),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            _navItem(icon: Icons.contacts_outlined, label: "Contacts", active: false),
            _navItem(icon: Icons.person_outline_rounded, label: "Profile", active: false),
          ],
        ),
      ),
    );
  }

  static Widget _navItem({
    required IconData icon,
    required String label,
    required bool active,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: active ? const Color(0xFFEF233C) : const Color(0xFF64748B),
          size: 22,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFEF233C) : const Color(0xFF64748B),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
// Required for physical hardware device vibrations
import '../services/sos_service.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSosSent = false;

  Future<void> _toggleSos() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Send SOS"),
        content: const Text(
          "Emergency contacts will be notified.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final sosService = SOSService();

      await sosService.triggerSOS(
        "Emergency",
      );

      if (!mounted) return;

      setState(() {
        _isSosSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "SOS saved successfully",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed: $e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good evening,",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(widget.userName,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: Color(0xFF18181C), shape: BoxShape.circle),
                      child: const Icon(Icons.notifications_none,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[900]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isSosSent ? Icons.check_circle : Icons.shield_outlined,
                        color:
                            _isSosSent ? Colors.green : const Color(0xFFE52E3D),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_isSosSent ? "SOS is active" : "You are safe",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              _isSosSent
                                  ? "Alert message broadcasted"
                                  : "Location shared with 3 contacts",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      Text("LIVE",
                          style: TextStyle(
                              color: _isSosSent
                                  ? Colors.green
                                  : const Color(0xFFE52E3D),
                              fontWeight: FontWeight.bold,
                              fontSize: 12))
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    _isSosSent
                        ? "SOS SENT SUCCESSFULLY"
                        : "HOLD TO ACTIVATE SOS",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ),
                const SizedBox(height: 30),
                // Replaced Expanded with a fixed-height container for the scrollable view
                Center(
                  child: GestureDetector(
                    onTap: _toggleSos,
                    child: Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            _isSosSent ? Colors.green : const Color(0xFFE52E3D),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isSosSent
                                    ? Colors.green
                                    : const Color(0xFFE52E3D))
                                .withOpacity(0.4),
                            blurRadius: 30,
                          )
                        ],
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _isSosSent ? "SENT" : "SOS",
                            style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text("QUICK ACTIONS",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuickAction(Icons.location_on_outlined,
                        "SHARE LOCATION", const Color(0xFFE52E3D)),
                    _buildQuickAction(Icons.phone_in_talk_outlined, "FAKE CALL",
                        Colors.purpleAccent),
                    _buildQuickAction(Icons.mic_none_outlined, "RECORD AUDIO",
                        Colors.orangeAccent),
                    _buildQuickAction(Icons.videocam_outlined, "RECORD VIDEO",
                        Colors.cyanAccent),
                  ],
                ),
                const SizedBox(height: 24),
                const Text("RECENT ACTIVITY",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildActivityRow("Location shared with Anjali", "2m ago",
                    const Color(0xFFE52E3D)),
                const SizedBox(height: 8),
                _buildActivityRow("Check-in completed", "1h ago", Colors.green),
                const SizedBox(
                    height: 20), // Added padding at bottom for better scrolling
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Container(
      width: 76,
      height: 85,
      decoration: BoxDecoration(
          color: const Color(0xFF111114),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String text, String time, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xFF111114),
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 8),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
          const Spacer(),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
// Required for physical hardware device vibrations
import '../services/sos_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:record/record.dart';

import '../services/location_service.dart';
import 'package:path_provider/path_provider.dart';

import '../services/audio_upload_service.dart';
import 'fake_call_screen.dart';
import '../services/contact_service.dart';

import 'dart:math';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSosSent = false;

  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isRecording = false;

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

      final sosId = await sosService.triggerSOS(
        "Emergency",
      );
      if (sosId != null) {
        await _recordEmergencyAudio().then(
          (audioPath) async {
            if (audioPath == null) return;

            await AudioUploadService().uploadAudio(
              sosId,
              audioPath,
            );
          },
        );
      }

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

  Future<void> _shareLocation() async {
    try {
      final locationService = LocationService();

      final position = await locationService.getCurrentLocation();

      final mapsUrl =
          "https://maps.google.com/?q=${position.latitude},${position.longitude}";

      await Share.share(
        "Emergency Location:\n$mapsUrl",
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unable to share location: $e"),
        ),
      );
    }
  }

  Future<void> _toggleAudioRecording() async {
    try {
      if (!_isRecording) {
        final dir = await getApplicationDocumentsDirectory();

        final path =
            '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(),
          path: path,
        );
        setState(() {
          _isRecording = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recording started"),
          ),
        );
      } else {
        final path = await _audioRecorder.stop();

        setState(() {
          _isRecording = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Audio saved:\n$path"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Recording failed: $e"),
        ),
      );
    }
  }

  Future<String?> _recordEmergencyAudio() async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      final path =
          '${dir.path}/sos_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(),
        path: path,
      );

      await Future.delayed(
        const Duration(seconds: 10),
      );

      final recordedPath = await _audioRecorder.stop();

      return recordedPath;
    } catch (e) {
      debugPrint(
        'Emergency recording failed: $e',
      );

      return null;
    }
  }

  Future<void> _fakeCall() async {
    final contacts = ContactService.getContacts();

    if (contacts.isEmpty) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No emergency contacts found"),
        ),
      );
      return;
    }

    final contact = contacts[Random().nextInt(contacts.length)];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${contact['name']} is calling..."),
      ),
    );

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FakeCallScreen(
          callerName: contact['name'],
          callerNumber: contact['phone'],
        ),
      ),
    );
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickAction(
                      Icons.location_on_outlined,
                      "SHARE LOCATION",
                      const Color(0xFFE52E3D),
                    ),
                    _buildQuickAction(
                      Icons.phone_in_talk_outlined,
                      "FAKE CALL",
                      Colors.purpleAccent,
                    ),
                    _buildQuickAction(
                      Icons.mic_none_outlined,
                      "RECORD AUDIO",
                      Colors.orangeAccent,
                    ),
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

  Widget _buildQuickAction(
    IconData icon,
    String label,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        if (label == "SHARE LOCATION") {
          _shareLocation();
        } else if (label == "RECORD AUDIO") {
          _toggleAudioRecording();
        } else if (label == "FAKE CALL") {
          _fakeCall();
        }
      },
      child: Container(
        width: 76,
        height: 85,
        decoration: BoxDecoration(
          color: const Color(0xFF111114),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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

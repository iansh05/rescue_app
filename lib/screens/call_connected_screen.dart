import 'dart:async';
import 'package:flutter/material.dart';

class CallConnectedScreen extends StatefulWidget {
  final String callerName;
  final String callerNumber;

  const CallConnectedScreen({
    super.key,
    required this.callerName,
    required this.callerNumber,
  });

  @override
  State<CallConnectedScreen> createState() => _CallConnectedScreenState();
}

class _CallConnectedScreenState extends State<CallConnectedScreen> {
  int seconds = 0;
  Timer? timer;

  bool mute = false;
  bool speaker = false;
  bool hold = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          seconds++;
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');

    final secs = (seconds % 60).toString().padLeft(2, '0');

    return "$mins:$secs";
  }

  Widget buildActionButton({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: active ? Colors.white24 : Colors.white10,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void showKeypad() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(
              12,
              (index) {
                final labels = [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '*',
                  '0',
                  '#'
                ];

                return Center(
                  child: Text(
                    labels[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[900],
              child: Text(
                widget.callerName[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.callerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formattedTime,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(
                  icon: Icons.mic_off,
                  label: "Mute",
                  active: mute,
                  onTap: () {
                    setState(() {
                      mute = !mute;
                    });
                  },
                ),
                buildActionButton(
                  icon: Icons.dialpad,
                  label: "Keypad",
                  active: false,
                  onTap: showKeypad,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(
                  icon: Icons.pause_circle,
                  label: "Hold",
                  active: hold,
                  onTap: () {
                    setState(() {
                      hold = !hold;
                    });
                  },
                ),
                buildActionButton(
                  icon: Icons.volume_up,
                  label: "Speaker",
                  active: speaker,
                  onTap: () {
                    setState(() {
                      speaker = !speaker;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 85,
                height: 85,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

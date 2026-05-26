import 'package:flutter/material.dart';
import 'dart:async';

class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key});

  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

enum CallState { idle, connected }

class _FakeCallScreenState extends State<FakeCallScreen> {
  CallState _callState = CallState.idle;
  Timer? _callTimer;
  int _callDuration = 0;
  int _selectedCaller = 0;
  bool _trackingEnabled = false;

  final List<String> _callerNames = ['Mom', 'Office', 'Unknown'];

  final List<Map<String, dynamic>> _companions = [
    {'initials': 'AM', 'name': 'Anjali Mehta', 'distance': '0.8 km away', 'online': true},
    {'initials': 'KN', 'name': 'Dr. Kavita Nair', 'distance': '2.3 km away', 'online': true},
    {'initials': 'RS', 'name': 'Rahul Sharma', 'distance': '4.1 km away', 'online': false},
  ];

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  void _triggerCall() {
    setState(() {
      _callState = CallState.connected;
      _callDuration = 0;
    });
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _callDuration++);
    });
  }

  void _endCall() {
    _callTimer?.cancel();
    setState(() {
      _callState = CallState.idle;
      _callDuration = 0;
    });
  }

  String _formatDuration(int secs) {
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HEADER ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141417),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF2A2A35)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 16),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Women Safety',
                          style: TextStyle(
                            color: Color(0xFFF1F5F9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Protection & Companion Features',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141417),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF7C4DFF).withOpacity(0.4)),
                      ),
                      child: const Icon(Icons.favorite_border_rounded,
                          color: Color(0xFF7C4DFF), size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── FAKE CALL CARD ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF7C4DFF).withOpacity(0.35)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C4DFF).withOpacity(0.08),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card title
                      Row(
                        children: [
                          Icon(Icons.phone_outlined,
                              color: const Color(0xFF7C4DFF).withOpacity(0.8), size: 16),
                          const SizedBox(width: 8),
                          const Text(
                            'FAKE CALL',
                            style: TextStyle(
                              color: Color(0xFF7C4DFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // ── IDLE STATE ──
                      if (_callState == CallState.idle) ...[
                        const Text(
                          'Simulate an incoming call to escape uncomfortable\nsituations discreetly.',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12.5,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Caller selector chips
                        Row(
                          children: List.generate(_callerNames.length, (i) {
                            final selected = _selectedCaller == i;
                            return Padding(
                              padding: EdgeInsets.only(right: i < 2 ? 10 : 0),
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedCaller = i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? const Color(0xFF7C4DFF).withOpacity(0.2)
                                        : const Color(0xFF1A1A1F),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: selected
                                          ? const Color(0xFF7C4DFF)
                                          : const Color(0xFF2A2A35),
                                      width: selected ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Text(
                                    _callerNames[i],
                                    style: TextStyle(
                                      color: selected
                                          ? const Color(0xFFF1F5F9)
                                          : const Color(0xFF94A3B8),
                                      fontSize: 13,
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),

                        // Trigger button
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: _triggerCall,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF7C4DFF), Color(0xFF9C6FFF)],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7C4DFF).withOpacity(0.4),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.phone_outlined,
                                      color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Trigger Fake Call',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],

                      // ── CONNECTED STATE ──
                      if (_callState == CallState.connected) ...[
                        const SizedBox(height: 4),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00C853),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Connected · ${_formatDuration(_callDuration)}',
                                style: const TextStyle(
                                  color: Color(0xFF00C853),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            _callerNames[_selectedCaller],
                            style: const TextStyle(
                              color: Color(0xFFF1F5F9),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: _endCall,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF233C),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x55EF233C),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.call_end,
                                  color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── LIVE COMPANION TRACKING CARD ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF7C4DFF).withOpacity(0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section title + toggle
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: const Color(0xFF7C4DFF).withOpacity(0.8), size: 16),
                          const SizedBox(width: 8),
                          const Text(
                            'LIVE COMPANION TRACKING',
                            style: TextStyle(
                              color: Color(0xFF7C4DFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: _trackingEnabled,
                            onChanged: (val) =>
                                setState(() => _trackingEnabled = val),
                            activeColor: const Color(0xFF7C4DFF),
                            activeTrackColor:
                                const Color(0xFF7C4DFF).withOpacity(0.35),
                            inactiveThumbColor: const Color(0xFF64748B),
                            inactiveTrackColor: const Color(0xFF1E1E25),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Companion list
                      ..._companions.map((c) => _companionTile(c)),

                      // Location sharing pill (only when tracking on)
                      if (_trackingEnabled) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C4DFF).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFF7C4DFF).withOpacity(0.25)),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.circle, color: Color(0xFF7C4DFF), size: 8),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Sharing your real-time location with all online companions',
                                  style: TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companionTile(Map<String, dynamic> c) {
    final bool online = c['online'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF7C4DFF).withOpacity(0.25),
            child: Text(
              c['initials'],
              style: const TextStyle(
                color: Color(0xFF7C4DFF),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name + distance
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['name'],
                  style: const TextStyle(
                    color: Color(0xFFF1F5F9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  c['distance'],
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Online dot
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: online ? const Color(0xFF00C853) : const Color(0xFF3A3A45),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

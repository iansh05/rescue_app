import 'package:flutter/material.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {

  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isSent = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF050505),

      body: Center(
        child: SizedBox(
          width: 390,

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    // TOP HEADER
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Good evening,",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              widget.userName,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding:
                          const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color:
                            const Color(0xFF151515),

                            borderRadius:
                            BorderRadius.circular(18),
                          ),

                          child: Stack(
                            children: [

                              const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                                size: 30,
                              ),

                              Positioned(
                                right: 0,
                                top: 0,

                                child: Container(
                                  height: 10,
                                  width: 10,

                                  decoration:
                                  const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // SAFETY STATUS CARD
                    Container(
                      padding:
                      const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color:
                        const Color(0xFF121212),

                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Row(
                        children: [

                          CircleAvatar(
                            radius: 22,

                            backgroundColor:
                            Colors.green.withOpacity(0.15),

                            child: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  "You are safe",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Location shared with 3 contacts",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Container(
                                height: 10,
                                width: 10,

                                decoration:
                                const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              const SizedBox(width: 6),

                              const Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // SOS TITLE
                    const Center(
                      child: Text(
                        "HOLD TO ACTIVATE SOS",
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 2,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // SOS BUTTON
                    Center(
                      child: GestureDetector(

                        onTap: () {

                          setState(() {
                            isSent = true;
                          });
                        },

                        child: AnimatedContainer(
                          duration:
                          const Duration(
                              milliseconds: 400),

                          height: 220,
                          width: 220,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            gradient: RadialGradient(
                              colors: isSent

                                  ? [
                                const Color(0xFF1DB954),
                                const Color(0xFF0D7A36),
                              ]

                                  : [
                                const Color(0xFFFF4B5C),
                                const Color(0xFFE0002B),
                              ],
                            ),

                            boxShadow: [

                              BoxShadow(
                                color: isSent

                                    ? Colors.green
                                    .withOpacity(0.6)

                                    : Colors.red
                                    .withOpacity(0.6),

                                blurRadius: 50,
                                spreadRadius: 10,
                              ),
                            ],
                          ),

                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Icon(
                                isSent

                                    ? Icons.check

                                    : Icons.warning_rounded,

                                color: Colors.white,
                                size: 60,
                              ),

                              const SizedBox(height: 12),

                              Text(
                                isSent
                                    ? "SENT"
                                    : "SOS",

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight:
                                  FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                isSent
                                    ? "ALERT SENT"
                                    : "EMERGENCY",

                                style: const TextStyle(
                                  color: Colors.white70,
                                  letterSpacing: 2,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // QUICK ACTIONS
                    const Text(
                      "QUICK ACTIONS",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        quickAction(
                          Icons.location_on,
                          "SHARE\nLOCATION",
                          Colors.red,
                        ),

                        quickAction(
                          Icons.call,
                          "FAKE CALL",
                          Colors.deepPurpleAccent,
                        ),

                        quickAction(
                          Icons.mic,
                          "RECORD\nAUDIO",
                          Colors.orange,
                        ),

                        quickAction(
                          Icons.videocam,
                          "RECORD\nVIDEO",
                          Colors.cyan,
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    // RECENT ACTIVITY
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(
                          "RECENT ACTIVITY",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          "See all",
                          style: TextStyle(
                            color: Colors.red[300],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    activityTile(
                      Icons.location_on,
                      "Location shared with Mom",
                      "2m ago",
                      Colors.red,
                    ),

                    const SizedBox(height: 15),

                    activityTile(
                      Icons.check_circle,
                      "Check-in completed",
                      "1h ago",
                      Colors.green,
                    ),

                    const SizedBox(height: 15),

                    activityTile(
                      Icons.warning_amber_rounded,
                      "Safety zone entered",
                      "3h ago",
                      Colors.orange,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 80,

        decoration: const BoxDecoration(
          color: Color(0xFF0F0F0F),
        ),

        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,

          children: [

            navItem(Icons.home, "Home", true),

            GestureDetector(
  onTap: () {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
  },

  child: navItem(Icons.map, "Map", false),
),

            Container(
              height: 65,
              width: 65,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,

                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.6),
                    blurRadius: 25,
                  ),
                ],
              ),

              child: const Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
            ),

            navItem(Icons.people, "Contacts", false),

            navItem(Icons.person, "Profile", false),
          ],
        ),
      ),
    );
  }

  Widget quickAction(
      IconData icon,
      String text,
      Color color,
      ) {

    return Container(
      height: 120,
      width: 78,

      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          CircleAvatar(
            radius: 18,

            backgroundColor:
            color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            text,
            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget activityTile(
      IconData icon,
      String title,
      String time,
      Color color,
      ) {

    return Container(
      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius:
        BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
            color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          Text(
            time,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(
      IconData icon,
      String label,
      bool active,
      ) {

    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,

      children: [

        Icon(
          icon,

          color: active
              ? Colors.red
              : Colors.grey,
        ),

        const SizedBox(height: 4),

        Text(
          label,

          style: TextStyle(
            color: active
                ? Colors.red
                : Colors.grey,

            fontSize: 11,
          ),
        ),
      ],
    );
  }
}   
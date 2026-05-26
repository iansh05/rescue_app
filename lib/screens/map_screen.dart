import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'home_screen.dart';
import 'emergency_screen.dart';
// import 'profile_screen.dart'; // add if you have it

import '../services/location_service.dart';
import '../offline/connectivity_service.dart';
import '../offline/offline_storage.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  // =========================
  // CONTROLLERS
  // =========================

  TextEditingController customEmergencyController =
      TextEditingController();

  // =========================
  // SERVICES
  // =========================

  final LocationService locationService =
      LocationService();

  final ConnectivityService connectivityService =
      ConnectivityService();

  final OfflineStorage offlineStorage =
      OfflineStorage();

  final MapController mapController =
      MapController();

  // =========================
  // VARIABLES
  // =========================

  String selectedEmergency = "Flood";

  String connectionStatus = "Checking...";

  bool locationLoaded = false;

  bool showPendingSOS = false;

  List pendingSOS = [];

  List<Marker> emergencyMarkers = [];

  LatLng currentLocation =
      LatLng(28.6139, 77.2090);

  // =========================
  // LOCATION
  // =========================

  Future<void> getLocation() async {

    Position position =
        await locationService.getCurrentLocation();

    setState(() {

      currentLocation = LatLng(
        position.latitude,
        position.longitude,
      );

    });

    if (!locationLoaded) {

      mapController.move(currentLocation, 15);

      locationLoaded = true;
    }
  }

  // =========================
  // INTERNET CHECK
  // =========================

  Future<void> checkInitialConnection() async {

    final result =
        await Connectivity().checkConnectivity();

    setState(() {

      if (result.contains(
          ConnectivityResult.none)) {

        connectionStatus = "Offline";

      } else {

        connectionStatus = "Online";

        if (pendingSOS.isNotEmpty) {

          print("Syncing pending SOS...");
        }
      }
    });
  }

  // =========================
  // LOAD PENDING SOS
  // =========================

  void loadPendingSOS() {

    setState(() {

      pendingSOS =
          offlineStorage.getSOSList();

    });
  }

  // =========================
  // SOS LOGIC
  // =========================

  void handleSOS() {

    String emergencyType =
        selectedEmergency == "Other"
        ? customEmergencyController.text
        : selectedEmergency;

    if (connectionStatus == "Offline") {

      offlineStorage.saveSOS(

        type: emergencyType,

        latitude: currentLocation.latitude,

        longitude: currentLocation.longitude,

      );

      loadPendingSOS();

      setState(() {

        emergencyMarkers.add(

          Marker(

            point: currentLocation,

            width: 80,
            height: 80,

            child: Icon(

              Icons.warning,

              color: getMarkerColor(
                emergencyType,
              ),

              size: 40,
            ),
          ),
        );

      });

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "SOS stored offline successfully",
          ),

          backgroundColor: Colors.orange,
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "SOS sent successfully",
          ),

          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // =========================
  // MARKER COLORS
  // =========================

  Color getMarkerColor(String type) {

    switch(type) {

      case "Fire":
        return Colors.red;

      case "Flood":
        return Colors.blue;

      case "Medical":
        return Colors.green;

      case "Earthquake":
        return Colors.orange;

      default:
        return Colors.purple;
    }
  }

  // =========================
  // INIT
  // =========================

  @override
  void initState() {
    super.initState();

    getLocation();

    checkInitialConnection();

    loadPendingSOS();

    connectivityService.connectivityStream
        .listen((result) {

      setState(() {

        if (result.contains(
            ConnectivityResult.none)) {

          connectionStatus = "Offline";

        } else {

          connectionStatus = "Online";

          if (pendingSOS.isNotEmpty) {

            print(
              "Syncing pending SOS..."
            );
          }
        }

      });

    });
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;

    return Scaffold(

<<<<<<< Updated upstream
      backgroundColor: Colors.grey[100],

      // =====================
      // BIG SOS BUTTON
      // =====================

      floatingActionButton:
          FloatingActionButton.extended(

        backgroundColor: Colors.red,

        elevation: 10,
=======
      body: Center(
        child: SizedBox(
          width: 390,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Live Map",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
>>>>>>> Stashed changes

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(20),
        ),

        onPressed: () {

<<<<<<< Updated upstream
          handleSOS();

        },

        icon: const Icon(
          Icons.sos,
        ),

        label: const Text(

          "🚨 SEND SOS",

          style: TextStyle(

            fontSize: 18,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =====================
      // APP BAR
      // =====================

      appBar: AppBar(

        backgroundColor: Colors.redAccent,

        elevation: 8,

        centerTitle: true,

        title: const Text(
          "Emergency Rescue App",
        ),
      ),

      // =====================
      // STACK LAYOUT
      // =====================

      body: Stack(

        children: [

          // =====================
          // FULLSCREEN MAP
          // =====================

          FlutterMap(

            mapController: mapController,

            options: MapOptions(

              initialCenter:
                  currentLocation,

              initialZoom: 13,
            ),

            children: [

              TileLayer(

                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                userAgentPackageName:
                    'com.example.rescue_app',
              ),

              // =====================
              // MAP MARKERS
              // =====================

              MarkerLayer(

                markers: [

                  // Current location
                  Marker(

                    point: currentLocation,

                    width: 80,
                    height: 80,

                    child: const Icon(

                      Icons.my_location,

                      color: Colors.black,

                      size: 35,
                    ),
                  ),

                  // Emergency markers
                  ...emergencyMarkers,

                ],
              ),

            ],
          ),

          // =====================
          // TOP FLOATING OVERLAY
          // =====================

          Positioned(

            top: 15,
            left: 15,
            right: 15,

            child: Container(

              decoration: BoxDecoration(

                color:
                    Colors.black.withOpacity(0.35),

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(

                children: [

                  // =====================
                  // EMERGENCY DROPDOWN
                  // =====================

                  Padding(

                    padding:
                        const EdgeInsets.all(12),

                    child: Card(

                      elevation: 8,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),

                      child: Padding(

                        padding:
                            const EdgeInsets.all(12),

                        child:
                            DropdownButton<String>(

                          value:
                              selectedEmergency,

                          isExpanded: true,

                          underline:
                              const SizedBox(),

                          items: const [

                            DropdownMenuItem(

                              value: "Flood",

                              child:
                                  Text("🌊 Flood"),
                            ),

                            DropdownMenuItem(

                              value: "Fire",

                              child:
                                  Text("🔥 Fire"),
                            ),

                            DropdownMenuItem(

                              value: "Medical",

                              child:
                                  Text("🚑 Medical"),
                            ),

                            DropdownMenuItem(

                              value:
                                  "Earthquake",

                              child: Text(
                                  "🏚 Earthquake"),
                            ),

                            DropdownMenuItem(

                              value: "Other",

                              child:
                                  Text("✏ Other"),
                            ),

                          ],

                          onChanged: (value) {

                            setState(() {

                              selectedEmergency =
                                  value!;

                            });

                          },
                        ),
                      ),
                    ),
                  ),

                  // =====================
                  // CUSTOM EMERGENCY
                  // =====================

                  if (selectedEmergency ==
                      "Other")

                    Padding(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),

                      child: Card(

                        elevation: 8,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),

                        child: Padding(

                          padding:
                              const EdgeInsets.all(
                                  12),

                          child: TextField(

                            controller:
                                customEmergencyController,

                            decoration:
                                const InputDecoration(

                              border:
                                  OutlineInputBorder(),

                              labelText:
                                  "Enter emergency type",
                            ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  // =====================
                  // CONNECTIVITY BANNER
                  // =====================

                  Container(

                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    width: double.infinity,

                    padding:
                        const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      gradient:
                          connectionStatus ==
                                  "Offline"

                              ? const LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.deepOrange,
                                  ],
                                )

                              : const LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.teal,
                                  ],
                                ),

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Text(

                      connectionStatus ==
                              "Offline"

                          ? "⚠ Offline Mode - SOS will sync automatically"

                          : "🟢 Online",

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 16,

                        fontWeight:
                            FontWeight.bold,
                      ),

                      textAlign:
                          TextAlign.center,
                    ),
                  ),

                ],
              ),
            ),
          ),

          // =====================
          // EXPANDABLE PENDING SOS
          // =====================

          Positioned(

            bottom: 90,
            left: 10,
            right: 10,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: [

                // Toggle button
                GestureDetector(

                  onTap: () {

                    setState(() {

                      showPendingSOS =
                          !showPendingSOS;

                    });

                  },

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(

                      color:
                          Colors.black.withOpacity(
                              0.7),

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        Icon(

                          showPendingSOS

                              ? Icons
                                  .keyboard_arrow_down

                              : Icons
                                  .keyboard_arrow_up,

                          color: Colors.white,
                        ),

                        const SizedBox(width: 8),

                        const Text(

                          "Pending SOS",

                          style: TextStyle(

                            color: Colors.white,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Expandable cards
                if (showPendingSOS)

                  SizedBox(

                    height: 130,

                    child: pendingSOS.isEmpty

                        ? Card(

                            elevation: 8,

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),

                            child: const Center(

                              child: Text(

                                "No Pending SOS",

                                style: TextStyle(

                                  fontSize: 16,

                                  fontWeight:
                                      FontWeight.bold,

                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )

                        : ListView.builder(

                            scrollDirection:
                                Axis.horizontal,

                            itemCount:
                                pendingSOS.length,

                            itemBuilder:
                                (context, index) {

                              final sos =
                                  pendingSOS[index];

                              return SizedBox(

                                width: 260,

                                child: Card(

                                  elevation: 8,

                                  margin:
                                      const EdgeInsets
                                          .all(8),

                                  shape:
                                      RoundedRectangleBorder(

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                20),
                                  ),

                                  child: ListTile(

                                    leading:
                                        CircleAvatar(

                                      backgroundColor:
                                          Colors.red
                                              .shade100,

                                      child:
                                          const Icon(

                                        Icons.warning,

                                        color:
                                            Colors.red,
                                      ),
                                    ),

                                    title: Text(

                                      sos['type'],

                                      style:
                                          const TextStyle(

                                        fontWeight:
                                            FontWeight
                                                .bold,

                                        fontSize: 18,
                                      ),
                                    ),

                                    subtitle: Text(

                                      "Lat: ${sos['latitude']}\n"
                                      "Lng: ${sos['longitude']}\n"
                                      "⏳ Pending Sync",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

              ],
            ),
          ),

=======
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF071B2E),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [

                          Column(
                            children: List.generate(
                              6,
                              (index) => Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 1),
                                  color: Colors.blue.withOpacity(0.07),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: List.generate(
                              6,
                              (index) => Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 1),
                                  color: Colors.blue.withOpacity(0.07),
                                ),
                              ),
                            ),
                          ),

                          Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.4),
                                    blurRadius: 50,
                                    spreadRadius: 20,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF2D55),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            right: 18,
                            bottom: 18,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                "LIVE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111114),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.location_on, color: Color(0xFFFF2D55)),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MG Road, Bengaluru",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Karnataka 560001, India",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(radius: 6, backgroundColor: Colors.red),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "SAFE ZONES",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    safeZoneCard("Home", "12 Koramangala, Bengaluru", "1.2 km"),
                    const SizedBox(height: 16),
                    safeZoneCard("Office", "Whitefield, Bengaluru", "8.4 km"),
                    const SizedBox(height: 16),
                    safeZoneCard("College", "AKGEC, Ghaziabad", "5.1 km"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // ✅ BOTTOM NAVIGATION (ADDED)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen(userName: "User")),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MapScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const EmergencyScreen()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Emergency"),
        ],
      ),
    );
  }

  Widget safeZoneCard(String title, String address, String distance) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(address, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(distance,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
>>>>>>> Stashed changes
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  List pendingSOS = [];

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

    // Move map only once
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

      print("SOS stored locally");

    } else {

      print("SOS sent to server");
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

    return Scaffold(

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          handleSOS();

        },

        child: const Icon(Icons.save),
      ),

      appBar: AppBar(
        title: const Text(
          "Emergency Rescue App",
        ),
      ),

      body: Column(
        children: [

          // =====================
          // EMERGENCY DROPDOWN
          // =====================

          Padding(
            padding: const EdgeInsets.all(10),

            child: DropdownButton<String>(

              value: selectedEmergency,

              isExpanded: true,

              items: const [

                DropdownMenuItem(
                  value: "Flood",
                  child: Text("🌊 Flood"),
                ),

                DropdownMenuItem(
                  value: "Fire",
                  child: Text("🔥 Fire"),
                ),

                DropdownMenuItem(
                  value: "Medical",
                  child: Text("🚑 Medical"),
                ),

                DropdownMenuItem(
                  value: "Earthquake",
                  child: Text("🏚 Earthquake"),
                ),

                DropdownMenuItem(
                  value: "Other",
                  child: Text("✏ Other"),
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

          // =====================
          // CUSTOM EMERGENCY
          // =====================

          if (selectedEmergency == "Other")

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              child: TextField(

                controller:
                    customEmergencyController,

                decoration:
                    const InputDecoration(

                  labelText:
                      "Enter emergency type",

                  border:
                      OutlineInputBorder(),
                ),
              ),
            ),

          const SizedBox(height: 10),

          // =====================
          // CONNECTIVITY BANNER
          // =====================

          Container(

            width: double.infinity,

            padding:
                const EdgeInsets.all(10),

            color:
                connectionStatus == "Offline"
                ? Colors.red
                : Colors.green,

            child: Text(

              connectionStatus == "Offline"

                  ? "⚠ Offline Mode - SOS will sync automatically"

                  : "🟢 Online",

              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

              textAlign: TextAlign.center,
            ),
          ),

          // =====================
          // PENDING SOS LIST
          // =====================

          SizedBox(

            height: 120,

            child: ListView.builder(

              itemCount: pendingSOS.length,

              itemBuilder:
                  (context, index) {

                final sos =
                    pendingSOS[index];

                return ListTile(

                  leading: const Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),

                  title: Text(
                    sos['type'],
                  ),

                  subtitle: Text(
                    "Lat: ${sos['latitude']}\n"
                    "Lng: ${sos['longitude']}\n"
                    "⏳ Pending Sync",
                  ),
                );
              },
            ),
          ),

          // =====================
          // MAP
          // =====================

          Expanded(

            child: FlutterMap(

              mapController:
                  mapController,

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
                // DIFFERENT MAP MARKERS
                // =====================

                MarkerLayer(

                  markers: [

                    Marker(

                      point: currentLocation,

                      width: 80,
                      height: 80,

                      child: Icon(

                        // Different icons
                        selectedEmergency == "Fire"

                            ? Icons.local_fire_department

                            : selectedEmergency == "Flood"

                                ? Icons.water

                                : selectedEmergency == "Medical"

                                    ? Icons.medical_services

                                    : selectedEmergency == "Earthquake"

                                        ? Icons.warning

                                        : Icons.report_problem,

                        // Different colors
                        color:
                            getMarkerColor(
                          selectedEmergency,
                        ),

                        size: 40,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
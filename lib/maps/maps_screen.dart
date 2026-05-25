import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/location_service.dart';
import '../offline/connectivity_service.dart';
import '../offline/offline_storage.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String selectedEmergency = "Flood";
  final OfflineStorage offlineStorage =
    OfflineStorage();

  final LocationService locationService = LocationService();

  final ConnectivityService connectivityService =
      ConnectivityService();

  final MapController mapController = MapController();

  String connectionStatus = "Checking...";

  bool locationLoaded = false;

  LatLng currentLocation =
      LatLng(28.6139, 77.2090);

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
  Future<void> checkInitialConnection() async {

  final result =
      await Connectivity().checkConnectivity();

  setState(() {

    if (result.contains(ConnectivityResult.none)) {

      connectionStatus = "Offline";

    } else {

      connectionStatus = "Online";

    }

  });
}

  @override
  void initState() {
    super.initState();

    getLocation();
    checkInitialConnection();

    connectivityService.connectivityStream
        .listen((result) {

      setState(() {

        if (result.contains(
            ConnectivityResult.none)) {

          connectionStatus = "Offline";

        } else {

          connectionStatus = "Online";
        }

      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(

  onPressed: () {

    offlineStorage.saveSOS(

  type: selectedEmergency,

  latitude: currentLocation.latitude,

  longitude: currentLocation.longitude,

);

    print(
      offlineStorage.getSOSList(),
    );

  },

  child: const Icon(Icons.save),
),

      appBar: AppBar(
        title: const Text("OpenStreetMap"),
      ),

      body: Column(
        children: [
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

    ],

    onChanged: (value) {

      setState(() {

        selectedEmergency = value!;

      });

    },
  ),
),

          // Connectivity banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),

            color: connectionStatus == "Offline"
                ? Colors.red
                : Colors.green,

            child: Text(
              connectionStatus,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),

              textAlign: TextAlign.center,
            ),
          ),

          // Map section
          Expanded(
            child: FlutterMap(

              mapController: mapController,

              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 13,
              ),

              children: [

                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                  userAgentPackageName:
                      'com.example.rescue_app',
                ),

                MarkerLayer(
                  markers: [

                    Marker(
                      point: currentLocation,
                      width: 80,
                      height: 80,

                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
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
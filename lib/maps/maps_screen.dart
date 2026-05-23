import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';



class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final LocationService locationService = LocationService();
  final MapController mapController = MapController();

LatLng currentLocation = LatLng(28.6139, 77.2090);
Future<void> getLocation() async {

  Position position =
      await locationService.getCurrentLocation();

  setState(() {
    currentLocation =
        LatLng(position.latitude, position.longitude);
  });
  mapController.move(currentLocation, 15);
}
@override
void initState() {
  super.initState();
  getLocation();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("OpenStreetMap"),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.rescue_app',
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
    );

  }
}
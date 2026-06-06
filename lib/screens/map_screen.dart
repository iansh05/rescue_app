import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../services/safe_zone_service.dart';
import '../offline/offline_storage.dart';
import '../services/sync_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentLocation =
      const LatLng(12.9300, 77.6350); // Default fallback (Bengaluru)
  String _currentAddress = "Fetching live GPS location...";
  bool _isLoading = true;
  final SafeZoneService _safeZoneService = SafeZoneService();

  List<SafeZone> safeZones = [];
  final MapController _mapController = MapController();
  String connectionStatus = "Checking...";
  List pendingSOS = [];
  void loadPendingSOS() {
    setState(() {
      pendingSOS = OfflineStorage.getSOSList();
    });
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      setState(() {
        connectionStatus = "Offline";
      });
    } else {
      setState(() {
        connectionStatus = "Online";
      });

      if (pendingSOS.isNotEmpty) {
        await SyncService.syncPendingSOS();
      }
    }
  }

  Future<void> createSOS() async {
    await OfflineStorage.saveSOS(
      type: "Emergency",
      latitude: _currentLocation.latitude,
      longitude: _currentLocation.longitude,
    );

    loadPendingSOS();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SOS Stored Successfully"),
        ),
      );
    }
  }

  Future<void> openNavigation(
    double lat,
    double lng,
  ) async {
    await launchUrl(
      Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      ),
    );
  }

  // Custom Minimalist Dark Grid Style JSON matching your screenshot perfectly

  @override
  void initState() {
    super.initState();

    _determinePosition();

    loadPendingSOS();

    checkConnection();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = "Location services are disabled.";
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "Location permissions are denied.";
          _isLoading = false;
        });
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));
      safeZones = await _safeZoneService.getNearbySafeZones(
        position.latitude,
        position.longitude,
      );

      if (mounted) {
        setState(() {
          _currentLocation = LatLng(
            position.latitude,
            position.longitude,
          );

          _currentAddress =
              "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";

          _isLoading = false;
        });

        _mapController.move(
          _currentLocation,
          15,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _currentAddress = "Using default viewport blueprint coordinates";
      });
    }

    // Listens for device movement changes live
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 5),
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _mapController.move(
            _currentLocation,
            15,
          );
          _currentAddress =
              "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE52E3D),
        onPressed: createSOS,
        child: const Icon(Icons.sos),
      ),
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text("Live Map",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 4),
              Text("Your location is being shared",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              const SizedBox(height: 20),

              // Map Container (Fixed size, not scrolling)
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _currentLocation,
                          initialZoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.sentinel',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _currentLocation,
                                width: 50,
                                height: 50,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Color(0xFFE52E3D),
                                  size: 40,
                                ),
                              ),
                              ...safeZones.map(
                                (zone) => Marker(
                                  point: LatLng(
                                    zone.latitude,
                                    zone.longitude,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text(zone.name),
                                          content: Text(zone.type),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      zone.type == "hospital"
                                          ? Icons.local_hospital
                                          : zone.type == "police"
                                              ? Icons.local_police
                                              : Icons.local_fire_department,
                                      color: zone.type == "hospital"
                                          ? Colors.green
                                          : zone.type == "police"
                                              ? Colors.blue
                                              : Colors.orange,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text("LIVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      if (_isLoading)
                        Container(
                          color: Colors.black54,
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFFE52E3D))),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Coordinates Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color(0xFF111114),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFE52E3D)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Current Coordinates",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 2),
                          Text(_currentAddress,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 11),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),
              if (pendingSOS.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: pendingSOS.length,
                    itemBuilder: (context, index) {
                      final sos = pendingSOS[index];

                      return ListTile(
                        leading: const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                        title: Text(
                          sos['type'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: const Text(
                          "Pending Sync",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // Scrollable Safe Zones Section
              Text(
                "SAFE ZONES",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    ...safeZones.map(
                      (zone) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            openNavigation(
                              zone.latitude,
                              zone.longitude,
                            );
                          },
                          child: _buildSafeZoneRow(
                            zone.name,
                            zone.type.toUpperCase(),
                            "Nearby",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSafeZoneRow(String title, String subtitle, String distance) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF111114),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text(distance,
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

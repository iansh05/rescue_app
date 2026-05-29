import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = const LatLng(12.9300, 77.6350); // Default fallback (Bengaluru)
  String _currentAddress = "Fetching live GPS location...";
  bool _isLoading = true;

  // Custom Minimalist Dark Grid Style JSON matching your screenshot perfectly
  final String _darkMapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        { "color": "#0b111e" }
      ]
    },
    {
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        { "color": "#121926" },
        { "weight": 1.0 }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        { "color": "#050810" }
      ]
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
    _determinePosition();
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
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
      
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _currentAddress = "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";
          _isLoading = false;
        });
        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation, 15.0));
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _currentAddress = "Using default viewport blueprint coordinates";
      });
    }

    // Listens for device movement changes live
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5),
    ).listen((Position position) {
      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _currentAddress = "Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLocation));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER ROW
              const Text("Live Map", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text("Your location is being shared", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              const SizedBox(height: 20),
              
              // EXPANDED BLUEPRINT MAP CONTAINER
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D), // Deep dark void background matching your grid
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  clipBehavior: Clip.antiAlias, 
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 15.0),
                        myLocationEnabled: false, // Turn off native blue dot to custom render the red glowing pin
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        onMapCreated: (controller) {
                          _mapController = controller;
                          _mapController?.setMapStyle(_darkMapStyle); // Injects clean dark theme lines
                        },
                        // Custom vector markers array
                        markers: {
                          Marker(
                            markerId: const MarkerId('live_location'),
                            position: _currentLocation,
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                          ),
                        },
                      ),
                      
                      // Precise placement of the live badge directly over the map canvas
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                          child: const Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      if (_isLoading)
                        Container(
                          color: Colors.black54,
                          child: const Center(child: CircularProgressIndicator(color: Color(0xFFE52E3D))),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // CURRENT ADDRESS / COORDINATES CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFE52E3D)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Current Coordinates", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 2),
                          Text(_currentAddress, style: TextStyle(color: Colors.grey[600], fontSize: 11), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // SAFE ZONES CARDS
              Text("SAFE ZONES", style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Column(
                children: [
                  _buildSafeZoneRow("Home", "12 Koramangala, Bengaluru", "1.2 km"),
                  const SizedBox(height: 10),
                  _buildSafeZoneRow("Office", "Whitefield, Bengaluru", "8.4 km"),
                  const SizedBox(height: 10),
                  _buildSafeZoneRow("College", "Jayanagar, Bengaluru", "4.1 km"),
                ],
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
      decoration: BoxDecoration(color: const Color(0xFF111114), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text(distance, style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'services/location_service.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("GPS Test")),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {

              Position position =
                  await locationService.getCurrentLocation();

              print("Latitude: ${position.latitude}");
              print("Longitude: ${position.longitude}");
            },
            child: Text("Get Location"),
          ),
        ),
      ),
    );
  }
}
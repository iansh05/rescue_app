import 'dart:convert';
import 'package:http/http.dart' as http;

class SafeZone {
  final String name;
  final String type;
  final double latitude;
  final double longitude;

  SafeZone({
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  });
}

class SafeZoneService {
  Future<List<SafeZone>> getNearbySafeZones(
    double latitude,
    double longitude,
  ) async {
    final query = """
[out:json];
(
  node["amenity"="hospital"](around:15000,$latitude,$longitude);

  node["amenity"="police"](around:15000,$latitude,$longitude);
  way["amenity"="police"](around:15000,$latitude,$longitude);
  relation["amenity"="police"](around:15000,$latitude,$longitude);

  node["amenity"="fire_station"](around:15000,$latitude,$longitude);
  way["amenity"="fire_station"](around:15000,$latitude,$longitude);
  relation["amenity"="fire_station"](around:15000,$latitude,$longitude);
);
out;
""";

    final response = await http.post(
      Uri.parse(
        'https://overpass-api.de/api/interpreter',
      ),
      body: query,
    );

    if (response.statusCode != 200) {
      return [];
    }

    final data = jsonDecode(response.body);

    List<SafeZone> zones = [];

    for (final item in data['elements']) {
      final tags = item['tags'] ?? {};

      zones.add(
        SafeZone(
          name: tags['name'] ?? 'Unknown Location',
          type: tags['amenity'] ?? 'safe_zone',
          latitude: item['lat'],
          longitude: item['lon'],
        ),
      );
    }
    bool hasPolice = zones.any(
      (z) => z.type == "police",
    );

    bool hasFire = zones.any(
      (z) => z.type == "fire_station",
    );

    if (!hasPolice) {
      zones.add(
        SafeZone(
          name: "Nearest Police Station",
          type: "police",
          latitude: latitude,
          longitude: longitude,
        ),
      );
    }

    if (!hasFire) {
      zones.add(
        SafeZone(
          name: "Nearest Fire Station",
          type: "fire_station",
          latitude: latitude,
          longitude: longitude,
        ),
      );
    }

    return zones;
  }
}

class SOSRequest {
  final String id;
  final String type;
  final double latitude;
  final double longitude;
  final String status;
  final DateTime timestamp;

  SOSRequest({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

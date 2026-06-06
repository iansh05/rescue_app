class AuthoritySOS {
  final String id;
  final String userName;
  final String emergencyType;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  String status;

  AuthoritySOS({
    required this.id,
    required this.userName,
    required this.emergencyType,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.status,
  });
}

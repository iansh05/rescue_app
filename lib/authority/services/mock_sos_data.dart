import '../models/authority_sos.dart';

final List<AuthoritySOS> mockSOS = [
  AuthoritySOS(
    id: "SOS001",
    userName: "Rahul Sharma",
    emergencyType: "Medical",
    latitude: 30.3165,
    longitude: 78.0322,
    timestamp: DateTime.now(),
    status: "Pending",
  ),
  AuthoritySOS(
    id: "SOS002",
    userName: "Priya Singh",
    emergencyType: "Fire",
    latitude: 30.3240,
    longitude: 78.0412,
    timestamp: DateTime.now(),
    status: "Pending",
  ),
];

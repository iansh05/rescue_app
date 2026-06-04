class EmergencyContact {
  final String name;
  final String phone;

  EmergencyContact({
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory EmergencyContact.fromMap(Map map) {
    return EmergencyContact(
      name: map['name'],
      phone: map['phone'],
    );
  }
}

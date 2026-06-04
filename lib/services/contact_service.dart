import 'package:hive/hive.dart';

class ContactService {
  static final Box contactsBox = Hive.box('contactsBox');

  static Future<void> addContact({
    required String name,
    required String phone,
  }) async {
    await contactsBox.add({
      'name': name,
      'phone': phone,
    });
  }

  static List getContacts() {
    return contactsBox.values.toList();
  }

  static Future<void> deleteContact(int index) async {
    await contactsBox.deleteAt(index);
  }
}

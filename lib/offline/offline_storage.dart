import 'package:hive/hive.dart';

class OfflineStorage {

  final Box sosBox = Hive.box('sosBox');

  void saveSOS({

  required String type,
  required double latitude,
  required double longitude,

}) {

  sosBox.add({

    'type': type,
    'latitude': latitude,
    'longitude': longitude,
    'time': DateTime.now().toString(),

  });

}

  List getSOSList() {

    return sosBox.values.toList();

  }
}
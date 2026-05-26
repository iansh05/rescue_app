import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/login_screen.dart';
=======
import 'maps/maps_screen.dart';
>>>>>>> offline-maps

import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('sosBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Rescue App',
      home:  LoginScreen(),
=======
      home: MapsScreen(),
>>>>>>> offline-maps
    );
  }
}
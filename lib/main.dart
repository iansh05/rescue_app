import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive safely for the map & app state local storage
  await Hive.initFlutter();
  await Hive.openBox('settings');
  // Opens the box required by your pages
  await Hive.openBox('sosBox');
  await Hive.openBox('contactsBox');

  runApp(const SentinelApp());
}

class SentinelApp extends StatelessWidget {
  const SentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentinel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
        primaryColor: const Color(0xFFE52E3D),
      ),
      home: const MobileResponsiveWrapper(
        child: LoginScreen(),
      ),
    );
  }
}

/// Force-enforces a clean mobile preview aspect ratio if run on web/desktop viewports
class MobileResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const MobileResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background fill behind device chassis mock
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 450), // Standard Phone Width max
          child: child,
        ),
      ),
    );
  }
}

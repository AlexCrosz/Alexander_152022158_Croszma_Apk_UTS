import 'package:flutter/material.dart';
import 'package:croszma_apk/home.dart';
import 'package:croszma_apk/profile.dart';
import 'package:croszma_apk/settings.dart';
import 'package:croszma_apk/splash_screen.dart'; // Import SplashScreen
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/splash', // Mengarahkan ke splash screen terlebih dahulu
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

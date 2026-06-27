import 'package:flutter/material.dart';
import 'package:matrix_app/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Matrix App', home: SplashScreen());
  }
}

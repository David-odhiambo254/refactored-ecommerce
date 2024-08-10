import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/intro_page.dart';
import 'package:flutter_application_1/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: lightMode,
    );
  }
}
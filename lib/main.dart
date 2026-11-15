import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'splash_screen_ui.dart';

void main() {
  runApp(const BodyHealthCalculatorApp());
}

class BodyHealthCalculatorApp extends StatelessWidget {
  const BodyHealthCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Body Health Calculator',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5722),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      home: const SplashScreenUI(),
    );
  }
}

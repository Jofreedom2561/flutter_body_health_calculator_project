import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Body Health Calculator',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFDF3500),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Semantics(
                      image: true,
                      label: 'ภาพประกอบ Body Health Calculator',
                      child: Image.asset(
                        'assets/images/calculate.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'คำนวณหาค่าดัชนีมวลกาย (BMI)\n'
                      'คำนวณหาแคลอรี่ที่ร่างกายต้องการ (BMR)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDF3500),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Semantics(
                      image: true,
                      label: 'ตรามหาวิทยาลัยเอเชียตะวันออกเฉียงใต้',
                      child: Image.asset(
                        'assets/images/saulogo.png',
                        width: 64,
                        height: 64,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2026 SAU. All rights reserved.\n'
                      'Created by SAU Software Development Team',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

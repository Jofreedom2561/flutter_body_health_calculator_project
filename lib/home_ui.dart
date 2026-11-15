import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about_ui.dart';
import 'bmi_ui.dart';
import 'bmr_ui.dart';
import 'health_illustration.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 0;

  static const _screens = [BmiUI(), BmrUI(), AboutUI()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDF3500),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: const HealthIllustration(
            type: HealthIllustrationType.about,
            size: 34,
          ),
        ),
        title: Text(
          'Body Health Calculator',
          style: GoogleFonts.kanit(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 52,
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFDF3500),
        unselectedItemColor: Colors.black45,
        selectedLabelStyle: GoogleFonts.kanit(fontSize: 11),
        unselectedLabelStyle: GoogleFonts.kanit(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_outlined, size: 20),
            activeIcon: Icon(Icons.monitor_weight, size: 20),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined, size: 20),
            activeIcon: Icon(Icons.local_fire_department, size: 20),
            label: 'BMR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded, size: 20),
            activeIcon: Icon(Icons.info_rounded, size: 20),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

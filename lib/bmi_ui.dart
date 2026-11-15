import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'health_illustration.dart';

class BmiUI extends StatefulWidget {
  const BmiUI({super.key});

  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _category = 'การแปลผล';
  String? _error;

  void _calculateBMI() {
    final heightCm = double.tryParse(_heightController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (heightCm == null || weight == null || heightCm <= 0 || weight <= 0) {
      setState(() {
        _bmi = null;
        _category = '';
        _error = 'กรุณากรอกส่วนสูงและน้ำหนักเป็นตัวเลขที่มากกว่า 0';
      });
      return;
    }

    final heightMeters = heightCm / 100;
    final bmi = weight / (heightMeters * heightMeters);
    final category = switch (bmi) {
      < 18.5 => 'น้ำหนักต่ำกว่าเกณฑ์',
      < 23 => 'น้ำหนักสมส่วน',
      < 25 => 'น้ำหนักเกิน',
      < 30 => 'โรคอ้วนระดับ 1',
      _ => 'โรคอ้วนระดับ 2 หรืออ้วนมาก',
    };

    setState(() {
      _bmi = bmi;
      _category = category;
      _error = null;
    });
  }

  void _clear() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmi = null;
      _category = 'การแปลผล';
      _error = null;
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CalculatorHeading(
              illustrationType: HealthIllustrationType.bmi,
              title: 'คำนวณหาค่าดัชนีมวลกาย (BMI)',
            ),
            const SizedBox(height: 22),
            _inputField(
              label: 'น้ำหนัก (kg.)',
              hint: 'กรอกน้ำหนักของคุณ',
              controller: _weightController,
              icon: Icons.monitor_weight_outlined,
            ),
            const SizedBox(height: 14),
            _inputField(
              label: 'ส่วนสูง (cm.)',
              hint: 'กรอกส่วนสูงของคุณ',
              controller: _heightController,
              icon: Icons.height_rounded,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: GoogleFonts.kanit(
                  color: Colors.red.shade700,
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(height: 18),
            _actionButton(
              label: 'คำนวณ BMI',
              icon: Icons.calculate_outlined,
              onPressed: _calculateBMI,
            ),
            const SizedBox(height: 10),
            _clearButton(onPressed: _clear),
            const SizedBox(height: 18),
            _resultCard(
              title: 'BMI',
              value: _bmi?.toStringAsFixed(2) ?? '0.00',
              subtitle: _category,
              unit: '',
            ),
          ],
        ),
      ),
    );
  }
}

Widget _inputField({
  required String label,
  required String hint,
  required TextEditingController controller,
  required IconData icon,
}) {
  return TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    style: GoogleFonts.kanit(fontSize: 14),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFFDF3500)),
      labelText: label,
      hintText: hint,
      labelStyle: GoogleFonts.kanit(fontSize: 13),
      hintStyle: GoogleFonts.kanit(fontSize: 12, color: Colors.black38),
      filled: true,
      fillColor: const Color(0xFFFFFBFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD7C9D5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD7C9D5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDF3500), width: 1.5),
      ),
    ),
  );
}

Widget _actionButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 46,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      icon: Icon(icon, size: 19),
      label: Text(
        label,
        style: GoogleFonts.kanit(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget _clearButton({required VoidCallback onPressed}) {
  return SizedBox(
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFAAAAAA),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Text('ล้างข้อมูล', style: GoogleFonts.kanit(fontSize: 13)),
    ),
  );
}

Widget _resultCard({
  required String title,
  required String value,
  required String subtitle,
  required String unit,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFFC8E6C9),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      children: [
        Text(title, style: GoogleFonts.kanit(fontSize: 12)),
        Text(
          '$value${unit.isEmpty ? '' : ' $unit'}',
          style: GoogleFonts.kanit(
            color: const Color(0xFFFF3D38),
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        Text(subtitle, style: GoogleFonts.kanit(fontSize: 11)),
      ],
    ),
  );
}

class _CalculatorHeading extends StatelessWidget {
  const _CalculatorHeading({
    required this.illustrationType,
    required this.title,
  });

  final HealthIllustrationType illustrationType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 18),
        Semantics(
          image: true,
          label: 'ภาพประกอบการคำนวณ BMI',
          child: Image.asset(
            'assets/icons/bmi.png',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

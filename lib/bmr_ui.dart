import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum BmrGender { male, female }

class BmrUI extends StatefulWidget {
  const BmrUI({super.key});

  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  BmrGender _gender = BmrGender.male;
  double? _bmr;
  String? _error;

  void _calculateBMR() {
    final age = double.tryParse(_ageController.text.trim());
    final height = double.tryParse(_heightController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (age == null ||
        height == null ||
        weight == null ||
        age <= 0 ||
        height <= 0 ||
        weight <= 0) {
      setState(() {
        _bmr = null;
        _error = 'กรุณากรอกอายุ ส่วนสูง และน้ำหนักเป็นตัวเลขที่มากกว่า 0';
      });
      return;
    }

    final bmr = switch (_gender) {
      BmrGender.male =>
        88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age),
      BmrGender.female =>
        447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age),
    };

    setState(() {
      _bmr = bmr;
      _error = null;
    });
  }

  void _clear() {
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmr = null;
      _error = null;
      _gender = BmrGender.male;
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
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
            const _BmrHeading(),
            const SizedBox(height: 18),
            Text(
              'เพศ',
              style: GoogleFonts.kanit(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _genderOption(
                    BmrGender.male,
                    'ชาย',
                    Icons.male_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _genderOption(
                    BmrGender.female,
                    'หญิง',
                    Icons.female_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
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
            const SizedBox(height: 14),
            _inputField(
              label: 'อายุ (ปี)',
              hint: 'กรอกอายุของคุณ',
              controller: _ageController,
              icon: Icons.cake_outlined,
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
            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _calculateBMR,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: const Icon(Icons.calculate_outlined, size: 19),
                label: Text(
                  'คำนวณ BMR',
                  style: GoogleFonts.kanit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: _clear,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFAAAAAA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  'ล้างข้อมูล',
                  style: GoogleFonts.kanit(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text('BMR', style: GoogleFonts.kanit(fontSize: 12)),
                  Text(
                    _bmr?.toStringAsFixed(2) ?? '0.00',
                    style: GoogleFonts.kanit(
                      color: const Color(0xFFFF3D38),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  Text('kcal/day', style: GoogleFonts.kanit(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderOption(BmrGender gender, String label, IconData icon) {
    final selected = _gender == gender;
    return Material(
      color: selected ? const Color(0xFFFFE3D9) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? const Color(0xFFFF5722) : const Color(0xFFD7C9D5),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => setState(() => _gender = gender),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 19, color: const Color(0xFFDF3500)),
              const SizedBox(width: 6),
              Text(label, style: GoogleFonts.kanit(fontSize: 14)),
            ],
          ),
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

class _BmrHeading extends StatelessWidget {
  const _BmrHeading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'คำนวณหาอัตราการเผาผลาญที่ร่างกายต้องการ (BMR)',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 18),
        Semantics(
          image: true,
          label: 'ภาพประกอบหัวใจและการออกกำลังกาย',
          child: Image.asset(
            'assets/icons/bmr.png',
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

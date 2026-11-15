import 'package:flutter/material.dart';

enum HealthIllustrationType { bmi, bmr, about }

class HealthIllustration extends StatelessWidget {
  const HealthIllustration({super.key, required this.type, this.size = 132});

  final HealthIllustrationType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: switch (type) {
        HealthIllustrationType.bmi => 'ภาพประกอบเครื่องชั่งน้ำหนัก',
        HealthIllustrationType.bmr => 'ภาพประกอบหัวใจและการเผาผลาญ',
        HealthIllustrationType.about => 'ภาพประกอบสุขภาพ',
      },
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _HealthIllustrationPainter(type)),
      ),
    );
  }
}

class _HealthIllustrationPainter extends CustomPainter {
  const _HealthIllustrationPainter(this.type);

  final HealthIllustrationType type;

  static const _orange = Color(0xFFFF5722);
  static const _dark = Color(0xFF29323D);
  static const _teal = Color(0xFF51C8C0);
  static const _pale = Color(0xFFFFE8DF);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 132;
    canvas.save();
    canvas.scale(scale);
    canvas.drawCircle(const Offset(66, 66), 60, Paint()..color = _pale);

    switch (type) {
      case HealthIllustrationType.bmi:
        _paintScale(canvas);
      case HealthIllustrationType.bmr:
        _paintHeart(canvas);
      case HealthIllustrationType.about:
        _paintAbout(canvas);
    }
    canvas.restore();
  }

  void _paintScale(Canvas canvas) {
    final outline = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final body = RRect.fromRectAndRadius(
      const Rect.fromLTWH(34, 48, 64, 61),
      const Radius.circular(18),
    );
    canvas.drawRRect(body, Paint()..color = Colors.white);
    canvas.drawRRect(body, outline);

    final display = RRect.fromRectAndRadius(
      const Rect.fromLTWH(45, 58, 42, 19),
      const Radius.circular(7),
    );
    canvas.drawRRect(display, Paint()..color = _teal);
    canvas.drawRRect(display, outline);

    canvas.drawCircle(const Offset(66, 91), 13, Paint()..color = _orange);
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(66, 91), radius: 8),
      3.7,
      2.7,
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
    canvas.drawLine(const Offset(66, 91), const Offset(72, 85), outline);
    canvas.drawCircle(const Offset(66, 91), 2.5, Paint()..color = _dark);
  }

  void _paintHeart(Canvas canvas) {
    final heart = Path()
      ..moveTo(66, 102)
      ..cubicTo(57, 94, 34, 76, 34, 61)
      ..cubicTo(34, 42, 57, 37, 66, 53)
      ..cubicTo(75, 37, 98, 42, 98, 61)
      ..cubicTo(98, 76, 75, 94, 66, 102)
      ..close();
    canvas.drawPath(heart, Paint()..color = const Color(0xFFFF6B67));
    canvas.drawPath(
      heart,
      Paint()
        ..color = _dark
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeJoin = StrokeJoin.round,
    );

    final pulse = Path()
      ..moveTo(42, 68)
      ..lineTo(54, 68)
      ..lineTo(60, 58)
      ..lineTo(68, 79)
      ..lineTo(76, 63)
      ..lineTo(81, 68)
      ..lineTo(91, 68);
    canvas.drawPath(
      pulse,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _paintAbout(Canvas canvas) {
    final outline = Paint()
      ..color = _dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final person = Paint()..color = _orange;
    canvas.drawCircle(const Offset(66, 31), 11, Paint()..color = _teal);
    canvas.drawCircle(const Offset(66, 31), 11, outline);
    canvas.drawLine(
      const Offset(66, 44),
      const Offset(66, 77),
      person..strokeWidth = 9,
    );
    canvas.drawLine(const Offset(66, 53), const Offset(46, 67), outline);
    canvas.drawLine(const Offset(66, 53), const Offset(86, 67), outline);
    canvas.drawLine(const Offset(66, 76), const Offset(51, 99), outline);
    canvas.drawLine(const Offset(66, 76), const Offset(81, 99), outline);
    canvas.drawLine(const Offset(40, 107), const Offset(92, 107), outline);
  }

  @override
  bool shouldRepaint(covariant _HealthIllustrationPainter oldDelegate) {
    return oldDelegate.type != type;
  }
}

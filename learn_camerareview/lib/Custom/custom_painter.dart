import 'package:flutter/material.dart';

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = const Color.fromARGB(255, 155, 38, 9);

    final paintBox = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = const Color.fromARGB(255, 155, 38, 9);

    final directop = Rect.fromLTWH(
        size.width * 0.48, size.height * 0.15, 15, size.height * 0.15);

    final direcbot = Rect.fromLTWH(
        size.width * 0.48, size.height * 0.7, 15, size.height * 0.15);

    final center = Offset(size.width / 2, size.height / 2);

    final innerRectg = Rect.fromCenter(
        center: center, width: size.width * 0.8, height: size.height * 0.3);

    final roundRect =
        RRect.fromRectAndRadius(innerRectg, const Radius.circular(0.0));

    final rRectdirectop = RRect.fromRectAndCorners(
      directop,
      bottomLeft: const Radius.circular(90),
      bottomRight: const Radius.circular(90),
    );

    final rRectdirecbot = RRect.fromRectAndCorners(
      direcbot,
      topRight: const Radius.circular(180),
      topLeft: const Radius.circular(180),
    );

    final textbox = Path();
    textbox.addRRect(roundRect);

    canvas.drawPath(textbox, paintBox);

    canvas.drawRRect(
      rRectdirectop,
      paint,
    );

    canvas.drawRRect(
      rRectdirecbot,
      paint,
    );
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}

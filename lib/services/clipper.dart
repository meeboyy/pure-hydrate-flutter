import 'package:flutter/material.dart';

class BottleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Define the bottle shape using a combination of lines and curves
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.25, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width * 0.75, size.height * 0.9);
    path.lineTo(size.width * 0.75, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.25, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width * 0.75, size.height * 0.9);
    path.lineTo(size.width * 0.75, 0);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

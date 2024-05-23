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
    var path = Path()
      ..lineTo(0, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.01, 200, size.width * 0.5, 200)
      ..quadraticBezierTo(size.width * 0.99, 200, size.width, 200 * 0.9)
      ..lineTo(size.width, 0);
    final paint = Paint()
      ..color = Colors.black.withOpacity(.2)
      ..style = PaintingStyle.fill
      ..strokeWidth = 6;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

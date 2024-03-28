import 'package:flutter/material.dart';

import 'points.dart';
import 'spring.dart';

class RopePainter extends CustomPainter {
  late List<Points> particles;
  late List<Spring> springs;
  final double strokewidth;

  RopePainter(this.particles, this.springs, this.strokewidth);

  @override
  void paint(Canvas canvas, Size size) {
    var head = particles[0];
    var tail = particles[particles.length - 1];

    var paint = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.fill;

    var line = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.green,
          Colors.lightBlue,
          Colors.deepPurpleAccent,
          Colors.purple,
          Colors.pink,
          Colors.red
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      // ..color = Color.fromARGB(255, 100, 200, 244)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth
      ..blendMode = BlendMode.screen
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(head.position.x, head.position.y);

    for (var i = 1; i < particles.length - 1; i++) {
      var p = particles[i];
      var next = particles[i + 1];

      var midPoint2 = p.position + (next.position - p.position) * 0.66;

      path.quadraticBezierTo(
          p.position.x, p.position.y, midPoint2.x, midPoint2.y);
    }

    path.lineTo(tail.position.x, tail.position.y);
    canvas.drawPath(path, line);

    canvas.drawCircle(Offset(tail.position.x, tail.position.y), 2, paint);
  }

  @override
  bool shouldRepaint(RopePainter oldDelegate) => true;
}

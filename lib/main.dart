import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomPaint(
            foregroundPainter: MyPainter(),
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    var path = Path();
    var newPath = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    for (final PathMetric metric in path.computeMetrics()) {
      bool draw = true;
      double distance = 0.0;
      while (distance < metric.length) {
        if (draw) {
          newPath.addPath(
              metric.extractPath(distance, distance + 5), Offset.zero);
        }
        distance += 5;
        draw = !draw;
      }
    }
    canvas.drawPath(newPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

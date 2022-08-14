import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawLine extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final double strokeThickness;

  DrawLine(this.startPoint, this.endPoint, {this.strokeThickness = 1});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = this.strokeThickness
      ..style = PaintingStyle.stroke;
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

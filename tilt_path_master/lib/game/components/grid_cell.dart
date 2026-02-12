import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Represents a single cell in the game grid
class GridCell extends PositionComponent {
  final int row;
  final int col;
  final int pointValue;
  final bool isPath;
  final bool isPit;
  final bool isStart;
  final bool isGoal;
  
  bool isVisited = false;

  GridCell({
    required this.row,
    required this.col,
    required this.pointValue,
    required this.isPath,
    required this.isPit,
    required this.isStart,
    required this.isGoal,
    required Vector2 position,
    required Vector2 size,
  }) {
    this.position = position;
    this.size = size;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    
    // Determine cell color
    Paint cellPaint = Paint();
    
    if (isPit) {
      // Pit cells are dark with gradient
      cellPaint.shader = RadialGradient(
        colors: [Colors.black, Colors.grey.shade800],
      ).createShader(rect);
    } else if (isGoal) {
      // Goal cell is gold
      cellPaint.color = Colors.amber.shade400;
    } else if (isStart) {
      // Start cell is light green
      cellPaint.color = Colors.lightGreen.shade300;
    } else if (isVisited) {
      // Visited path cells are green
      cellPaint.color = Colors.green.shade400;
    } else if (isPath) {
      // Unvisited path cells are light gray
      cellPaint.color = Colors.grey.shade300;
    } else {
      // Non-path cells are dark
      cellPaint.color = Colors.brown.shade700;
    }

    canvas.drawRect(rect, cellPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(rect, borderPaint);

    // Draw point value for path cells
    if (isPath && !isPit && !isStart && pointValue > 0) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: pointValue.toString(),
          style: TextStyle(
            color: isVisited ? Colors.white : Colors.black87,
            fontSize: size.x * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.x - textPainter.width) / 2,
          (size.y - textPainter.height) / 2,
        ),
      );
    }

    // Draw special markers
    if (isStart) {
      _drawText(canvas, 'START', Colors.white);
    } else if (isGoal) {
      _drawText(canvas, 'GOAL', Colors.white);
    } else if (isPit) {
      _drawPitSymbol(canvas);
    }
  }

  void _drawText(Canvas canvas, String text, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size.x * 0.25,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }

  void _drawPitSymbol(Canvas canvas) {
    // Draw an X to indicate pit
    final paint = Paint()
      ..color = Colors.red.shade900
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    final margin = size.x * 0.3;
    canvas.drawLine(
      Offset(margin, margin),
      Offset(size.x - margin, size.y - margin),
      paint,
    );
    canvas.drawLine(
      Offset(size.x - margin, margin),
      Offset(margin, size.y - margin),
      paint,
    );
  }

  void setVisited(bool visited) {
    isVisited = visited;
  }
}

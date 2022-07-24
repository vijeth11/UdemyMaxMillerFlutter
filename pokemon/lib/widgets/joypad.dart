import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon/helper/direction.dart';
import 'package:pokemon/helper/draw_line.dart';

class JoyPad extends StatefulWidget {
  final Function onDirectionChanged;
  const JoyPad({Key? key, required this.onDirectionChanged}) : super(key: key);

  @override
  State<JoyPad> createState() => _JoyPadState();
}

class _JoyPadState extends State<JoyPad> {
  Direction direction = Direction.none;
  Offset delta = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 120,
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0x88ffffff), shape: BoxShape.circle),
            child: Stack(children: [
              CustomPaint(
                size: Size(120, 120),
                painter: DrawLine(Offset(15.0, 15.0), Offset(105, 105),
                    strokeThickness: 2),
              ),
              CustomPaint(
                size: Size(120, 120),
                painter: DrawLine(Offset(105.0, 15.0), Offset(15, 105),
                    strokeThickness: 2),
              ),
              Center(
                child: Transform.translate(
                  offset: delta,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
          onPanStart: onDragStart,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
        ));
  }

  Direction getDirection(Offset position) {
    if (position.dx > 20) {
      return Direction.right;
    }
    if (position.dx < -20) {
      return Direction.left;
    }
    if (position.dy > 20) {
      return Direction.down;
    }
    if (position.dy < -20) {
      return Direction.up;
    }
    return Direction.none;
  }

  void updateTheDelta(Offset update) {
    var newDirection = getDirection(update);
    if (newDirection != direction) {
      direction = newDirection;
      widget.onDirectionChanged(direction);
    }
    setState(() {
      delta = update;
    });
  }

  void currentStickPosition(Offset updatedPosition) {
    Offset newPosition = Offset.zero;
    // remove the area covered by stick 
    if (newPosition != updatedPosition)
      newPosition = updatedPosition - Offset(60, 60);
    // to keep the stick withing the outer circle which has radius of 30
    updateTheDelta(Offset.fromDirection(
        newPosition.direction, min(30, newPosition.distance)));
  }

  void onDragStart(DragStartDetails details) {
    currentStickPosition(details.localPosition);
  }

  void onDragUpdate(DragUpdateDetails details) {
    currentStickPosition(details.localPosition);
  }

  void onDragEnd(DragEndDetails details) {
    currentStickPosition(Offset.zero);
  }
}

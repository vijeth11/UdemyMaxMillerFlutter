import 'package:flutter/material.dart';
import 'package:pokemon/helper/draw_line.dart';

class JoyPad extends StatefulWidget {
  final Function onDirectionChanged;
  const JoyPad({Key? key, required this.onDirectionChanged}) : super(key: key);

  @override
  State<JoyPad> createState() => _JoyPadState();
}

class _JoyPadState extends State<JoyPad> {
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
                        color: const Color(0xccffffff),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}

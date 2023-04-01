import 'package:flutter/material.dart';

class HalfFilledIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color primaryColor;
  final Color secondaryColor;

  HalfFilledIcon({required this.icon, required this.size, required this.primaryColor, required this.secondaryColor,});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: const [0, 0.5, 0.5],
          colors: [primaryColor, primaryColor, primaryColor.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon, size: size, color: secondaryColor),
      ),
    );
  }
}

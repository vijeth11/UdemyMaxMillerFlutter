import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';

class SaveChangesButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double verticalHeight;
  final Color fontColor;
  final Color BackgroundColor;
  const SaveChangesButton(
      {super.key,
      required this.onPress,
      this.title = "Save Changes",
      this.verticalHeight = 0,
      this.fontColor = kWhiteColor,
      this.BackgroundColor = kGreenColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: buttonStyle.copyWith(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [BackgroundColor, BackgroundColor.withOpacity(0.7)])),
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: verticalHeight)),
          child: Text(
            title,
            style: TextStyle(color: fontColor),
          ),
        ),
      ),
    );
  }
}

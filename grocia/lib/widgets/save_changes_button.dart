import 'package:flutter/material.dart';
import 'package:grocia/constants/constants.dart';

class SaveChangesButton extends StatelessWidget {
  final VoidCallback onPress;
  const SaveChangesButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration:
            buttonStyle.copyWith(borderRadius: BorderRadius.circular(5)),
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20)),
          child: Text("Save Changes"),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MessageTextBox extends StatelessWidget {
  final String textToDisplay;

  MessageTextBox(this.textToDisplay);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      this.textToDisplay,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    ));
  }
}

import 'package:flutter/material.dart';

Widget getPageButton(String title, VoidCallback onPress) {
  return ElevatedButton(
    onPressed: onPress,
    child: Text(title),
    style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: MaterialStateProperty.all(Colors.green.shade500),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        alignment: Alignment.center,
        minimumSize:
            MaterialStateProperty.all(const Size(double.infinity, 60))),
  );
}

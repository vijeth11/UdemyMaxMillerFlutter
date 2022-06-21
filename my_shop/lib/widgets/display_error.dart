import 'package:flutter/material.dart';

void displayError(error, context, Function onPress) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('An Error occured'),
          content: Text(error.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  onPress();
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'))
          ],
        );
      });
}

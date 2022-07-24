import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final VoidCallback HandleClick;

  CounterButton(this.HandleClick);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        child: Text("Click me!"),
        onPressed: this.HandleClick,
      ),
      alignment: Alignment.center,
    );
  }
}

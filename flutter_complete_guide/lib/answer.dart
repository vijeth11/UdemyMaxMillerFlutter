import 'package:flutter/materiAL.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String element;
  final Function callBack;
  final int score;

  //constructor
  Answer(this.element, this.callBack, this.score);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: new ElevatedButton(
        onPressed: () => this.callBack(this.element, this.score),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue, onPrimary: Colors.black),
        child: Text(
          this.element,
        ),
      ),
    );
  }
}

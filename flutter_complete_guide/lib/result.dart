import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  VoidCallback handlerCallback;

  Result(this.resultScore, this.handlerCallback);

  String get resultPhrase {
    var resultText = "";
    if (resultScore <= 8) {
      resultText = "You are awsome and innocent!";
    } else if (resultScore <= 12) {
      resultText = "Pretty likeable";
    } else if (resultScore <= 16) {
      resultText = " You are ... strange?!";
    } else {
      resultText = "You are so bad!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          this.resultPhrase,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: this.handlerCallback, child: Text("Restart Quiz!"))
      ],
    ));
  }
}

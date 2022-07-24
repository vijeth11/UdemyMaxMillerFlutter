import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // this re-renders widget on change of the data and call to setState method
  // Class extendidng stateless does not re-Render when data of properties change
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // all changing variables should be class property
  // this is the state class used by StatefulWidget
  // object of this class needs to be created and returned in createState method
  // this class should extend State class with type of class which extends statefulwidgt (ex: MyApp)
  // setState method calls build method again and re-renders the widget tree
  Map<String, List<Map<String, Object>>> _questions = {
    "What's your favorite color?": [
      {'text': 'Black', 'score': 10},
      {'text': 'Red', 'score': 5},
      {'text': 'Green', 'score': 3},
      {'text': 'white', 'score': 1},
    ],
    "What's your favorite animal?": [
      {'text': 'Rabbit', 'score': 10},
      {'text': 'Snake', 'score': 5},
      {'text': 'Elephant', 'score': 3},
      {'text': 'Lion', 'score': 1},
    ],
    "Who's your favorite instructor?": [
      {'text': 'Max', 'score': 1},
      {'text': 'ZTM', 'score': 1},
      {'text': 'Self', 'score': 1},
    ]
  };

  int _QuestionSelected = 0;

  String _AnswerSelected = "Current No answer selected";

  bool _DisplayCenterText = false;

  int _currentScore = 0;

  void answerTheQuestion(String element, int score) {
    if (_QuestionSelected < _questions.length - 1) {
      setState(() {
        _AnswerSelected = element;
        _QuestionSelected = _QuestionSelected + 1;
        this._currentScore += score;
      });
    } else {
      setState(() {
        this._DisplayCenterText = true;
      });
    }
    print(element);
  }

  void resetQuiz() {
    setState(() {
      this._currentScore = 0;
      this._QuestionSelected = 0;
      this._DisplayCenterText = false;
      this._AnswerSelected = "Current No answer selected";
    });
  }

  @override
  Widget build(BuildContext context) {
    var material = new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("My First App"),
            ),
            body: this._DisplayCenterText
                ? Result(this._currentScore, this.resetQuiz)
                : Quiz(this._questions, this._QuestionSelected,
                    this.answerTheQuestion, this._AnswerSelected)));
    return material;
  }
}

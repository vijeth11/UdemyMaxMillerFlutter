import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/question.dart';

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
  List<String> _questions = [
    "What's your favorite color?",
    "What's your favorite animal?"
  ];

  int _QuestionSelected = 0;

  List<String> _answers = [
    'Answer1',
    'Answer2',
    'Answer3',
  ];

  String _AnswerSelected = "Current No answer selected";

  void answerTheQuestion(String element) {
    setState(() {
      _AnswerSelected = element;
      _QuestionSelected =
          _QuestionSelected < _questions.length ? _QuestionSelected + 1 : 0;
    });
    print(element);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      new Text(
        "Questions to be Answered",
      ),
      new Question(this._questions[this._QuestionSelected])
    ];

    _answers.forEach((element) {
      items.add(new ElevatedButton(
        onPressed: () => this.answerTheQuestion(element),
        child: Text(
          element,
        ),
      ));
    });

    items.add(Text(
      _AnswerSelected,
    ));
    var material = new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("My First App"),
            ),
            body: Column(
              children: items,
            )));
    return material;
  }
}

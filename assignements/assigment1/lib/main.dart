// ignore_for_file: unnecessary_new

import 'package:assigment1/counterButton.dart';
import 'package:assigment1/message.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new AssignmentApp());
}

class AssignmentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AssignmentState();
  }
}

class AssignmentState extends State<AssignmentApp> {
  int counter = 0;

  void onButtonClick() {
    setState(() {
      counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Assignment 1"), centerTitle: true),
          body: Column(
            children: [
              MessageTextBox(this.counter.toString()),
              CounterButton(this.onButtonClick)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )),
    );
  }
}

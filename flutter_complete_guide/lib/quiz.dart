import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';

class Quiz extends StatelessWidget {
  final Map<String, List<Map<String, Object>>> _questions;
  final int _QuestionSelected;
  final Function answerTheQuestion;
  final String _AnswerSelected;

  Quiz(this._questions, this._QuestionSelected, this.answerTheQuestion,
      this._AnswerSelected);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      new Text(
        "Questions to be Answered",
      ),
      new Question(this._questions.keys.elementAt(this._QuestionSelected)),
      ...?this
          ._questions[this._questions.keys.elementAt(this._QuestionSelected)]
          ?.map((e) => new Answer(
              e['text'] as String, this.answerTheQuestion, e['score'] as int))
          .toList(),
      new Text(
        _AnswerSelected,
      )
    ];

    return Column(
      children: items,
    );
  }
}

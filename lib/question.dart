import 'package:flutter/cupertino.dart';

class Question extends StatelessWidget {
  final String _question;

  Question(this._question);

  @override
  Widget build(BuildContext context) {
    return new Text(this._question);
  }
}

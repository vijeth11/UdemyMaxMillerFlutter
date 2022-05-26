import 'package:flutter/cupertino.dart';

class Question extends StatelessWidget {
  final String _question;

  Question(this._question);

  @override
  Widget build(BuildContext context) {
    // containser works as a wrapper like div and takes only 1 child
    return new Container(
        width: double.infinity,
        margin: new EdgeInsets.all(10),
        child: new Text(
          this._question,
          style: new TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DialogOverlay extends StatelessWidget {
  const DialogOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('the message will be displayed here');
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Widget getTextInput(
    {int maxLines = 1,
    TextInputType type = TextInputType.text,
    bool obscureText = false,
    Function(String?)? saved,
    List<TextInputFormatter>? textFormatter,
    TextEditingController? controller,
    String? Function(String?)? validate,
    String? initialValue,
    String placeHolder = ""}) {
  return TextFormField(
    maxLines: maxLines,
    keyboardType: type,
    controller: controller,
    validator: validate,
    initialValue: initialValue,
    obscureText: obscureText,
    inputFormatters: textFormatter,
    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        hintText: placeHolder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    onSaved: saved,
  );
}

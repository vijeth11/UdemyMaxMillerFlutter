import 'package:flutter/material.dart';

List<Widget> getInputForm(String title) {
  return [
    Text(title),
    TextFormField(
      decoration: InputDecoration(
          hintText: title, contentPadding: EdgeInsets.only(left: 10)),
    )
  ];
}

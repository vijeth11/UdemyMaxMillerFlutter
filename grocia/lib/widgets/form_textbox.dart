import 'package:flutter/material.dart';

List<Widget> getInputForm(String title, {IconData? icon}) {
  return [
    Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w700),
    ),
    TextFormField(
      decoration: InputDecoration(
          labelText: title,
          contentPadding: EdgeInsets.only(left: 10),
          suffixIcon: icon != null ? Icon(icon) : null),
    )
  ];
}

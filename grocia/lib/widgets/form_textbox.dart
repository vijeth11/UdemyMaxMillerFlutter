import 'package:flutter/material.dart';

List<Widget> getInputForm(
  String title, {
  IconData? icon,
  bool isSuffix = true,
  InputBorder? border,
  VoidCallback? onIconPress,
}) {
  return [
    Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w700),
    ),
    TextFormField(
      decoration: InputDecoration(
          border: border,
          labelText: title,          
          contentPadding: const EdgeInsets.only(left: 10),
          suffixIcon: isSuffix && icon != null
              ? onIconPress != null
                  ? IconButton(onPressed: onIconPress, icon: Icon(icon))
                  : Icon(icon)
              : null,
          prefixIcon: !isSuffix && icon != null
              ? onIconPress != null
                  ? IconButton(onPressed: onIconPress, icon: Icon(icon))
                  : Icon(icon)
              : null),
    )
  ];
}

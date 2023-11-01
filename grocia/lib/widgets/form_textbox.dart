import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Widget> getInputForm(
  String title, {
  TextInputType? type,
  TextInputAction? action,
  dynamic Function(String?)? saved,
  String? Function(String?)? validate,
  bool obscureText = false,
  IconData? icon,
  bool isSuffix = true,
  InputBorder? border,
  VoidCallback? onIconPress,
  FocusNode? node,
  List<TextInputFormatter>? textFormatter,
  TextEditingController? controller,
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
      textInputAction: action,
      inputFormatters: textFormatter,
      keyboardType: type,
      obscureText: obscureText,
      onSaved: saved,
      validator: validate,
      focusNode: node,
      controller: controller,
    )
  ];
}

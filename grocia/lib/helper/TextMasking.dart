import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextMasking extends TextInputFormatter {
  // masking should contain xxx ex:(xxx) xxxx-xxxx
  final String format;

  TextMasking(this.format);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    String value = newValue.text.replaceAll(RegExp(r'[^a-z0-9]'), "");
    String finalValue = format.toLowerCase();
    for (var i in value.characters) {
      finalValue = finalValue.replaceFirst(RegExp(r'x'), i);
    }
    if (finalValue.contains('x')) {
      finalValue = finalValue.substring(0, finalValue.indexOf('x'));
    }
    if (finalValue.contains('-') &&
        finalValue.indexOf('-') == finalValue.length - 1) {
      finalValue = finalValue.substring(0, finalValue.length - 1);
    }
    return TextEditingValue(
      text: finalValue.trim(),
      selection: TextSelection.collapsed(offset: finalValue.length),
    );
  }
}

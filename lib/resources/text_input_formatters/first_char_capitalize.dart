import 'package:flutter/services.dart';

class FirstCharCapitalize extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text.isNotEmpty) {
      text = text.replaceFirst(text[0], text[0].toUpperCase());
    }
    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }
}
// Text Input Formater for every first letter uppercase////
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalizeAllWord(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}
/////////////////////////////////
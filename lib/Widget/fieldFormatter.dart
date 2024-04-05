import 'package:flutter/services.dart';

class RegexFormatter extends FilteringTextInputFormatter {
  RegexFormatter.allow(super.filterPattern) : super.allow();
  static FilteringTextInputFormatter email =
      FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9.@]'));
  static FilteringTextInputFormatter phone =
      FilteringTextInputFormatter.allow(RegExp(r'\d+'));

  static FilteringTextInputFormatter regNo =
      FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9]'));
}

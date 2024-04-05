import 'package:alpha_work/Utils/color.dart';
import 'package:flutter/material.dart';

DropDownDeco<decoration>({required BuildContext ctx}) {
  return BoxDecoration(
    color: Theme.of(ctx).brightness == Brightness.dark
        ? colors.textFieldBG
        : Colors.white,
    border: Border.all(
      // Set the border color and width
      color: Theme.of(ctx).brightness == Brightness.dark
          ? colors.white10
          : colors.textFieldBG, // Replace with your desired border color
      width: 1.0, // Replace with your desired border width
    ),
    borderRadius: BorderRadius.circular(10.0),
  );
}

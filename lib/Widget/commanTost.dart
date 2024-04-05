import 'package:alpha_work/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showTost() {
  return Fluttertoast.showToast(
      msg: "Something went wrong!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors.buttonColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

import 'package:flutter/material.dart';
import '../../utils/color.dart';

class DrawerText extends StatelessWidget {
  final String text;
  const DrawerText(String s, {Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: colors.textColor, fontSize: 15),
    );
  }
}

class SignupHeadingText extends StatelessWidget {
  final String text;
  const SignupHeadingText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: colors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class Text14 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text14({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

class Text16 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;

  const Text16({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16,
          color: light ?? const Color.fromARGB(255, 94, 90, 90),
          fontWeight: bold ?? FontWeight.normal,
          fontFamily: 'RaleWay'),
    );
  }
}

class Text18 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text18({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

class Text20 extends StatelessWidget {
  final String text;
  final Color? light;
  final FontWeight? bold;
  const Text20({Key? key, required this.text, this.light, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          color: light ?? colors.textColor,
          fontWeight: bold ?? FontWeight.normal),
    );
  }
}

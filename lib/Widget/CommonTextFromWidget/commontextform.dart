import 'package:flutter/material.dart';

import '../../Utils/color.dart';

class CommonTextForm extends StatelessWidget {
  late TextEditingController controllername;
  late String labelname;
  CommonTextForm(
      {super.key, required this.controllername, required this.labelname});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      onChanged: (value) {
        if (value.length == 10) {
          // FocusScope.of(context).unfocus();
        }
      },
      controller: controllername,
      decoration: InputDecoration(
        labelText: labelname,
        labelStyle: const TextStyle(
            color: colors.lightTextColor, fontStyle: FontStyle.normal),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    ));
  }
}

class CommonPAssword extends StatefulWidget {
  late TextEditingController controllername;
  late String labelname;
  CommonPAssword(
      {super.key, required this.controllername, required this.labelname});

  @override
  State<CommonPAssword> createState() => _CommonPAsswordState();
}

class _CommonPAsswordState extends State<CommonPAssword> {
  bool passwordshowstatus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      obscureText: passwordshowstatus,
      onChanged: (value) {
        if (value.length == 10) {
          // FocusScope.of(context).unfocus();
        }
      },
      controller: widget.controllername,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (passwordshowstatus) {
                  passwordshowstatus = false;
                } else {
                  passwordshowstatus = true;
                }
              });
            },
            icon: const Icon(Icons.visibility_outlined)),
        labelText: widget.labelname,
        labelStyle: const TextStyle(
            color: colors.lightTextColor, fontStyle: FontStyle.normal),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    ));
  }
}

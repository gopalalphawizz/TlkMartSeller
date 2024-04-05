import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool pass = false;
  bool pass1 = false;
  bool pass2 = false;
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  late ProfileViewModel profileP;
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*()_+{}|:<>?~]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  @override
  void initState() {
    profileP = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Change Password"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: oldPass,
                  textInputAction: TextInputAction.next,
                  obscureText: pass,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter old passward";
                    }
                    return null;
                  },
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        labelText: "Old Password",
                      suffixIcon: IconButton(onPressed: () => setState(() {
                        pass=!pass;
                      }), icon: Icon(pass?Icons.visibility_off:Icons.visibility))
                      ),
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  controller: newPass,
                  textInputAction: TextInputAction.next,
                  validator: (value) => validatePassword(value),
                  obscureText: pass1,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        labelText: "New Password",
                      suffixIcon: IconButton(onPressed: () => setState(() {
                        pass1=!pass1;
                      }), icon: Icon(pass1?Icons.visibility_off:Icons.visibility))
                      ),
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  controller: confirmPass,
                  textInputAction: TextInputAction.done,
                  obscureText: pass2,
                  validator: (value) => validatePassword(value),
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        labelText: "Confirm Password",
                      suffixIcon: IconButton(onPressed: () => setState(() {
                        pass2=!pass2;
                      }), icon: Icon(pass2?Icons.visibility_off:Icons.visibility))
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (oldPass.text == newPass.text) {
                Fluttertoast.showToast(
                    msg: "New password cannot be same as Old password");
              } else if (newPass.text != confirmPass.text) {
                Fluttertoast.showToast(msg: "Password do not match");
              } else {
                await profileP
                    .cahngePassword(
                        old_password: oldPass.text.toString(),
                        newPass: newPass.text.toString(),
                        confirmPass: confirmPass.text.toString())
                    .then((value) => Fluttertoast.showToast(
                          msg: value,
                          backgroundColor: colors.buttonColor,
                          textColor: Colors.white,
                        ));
                Navigator.pop(context);
              }
            }
          },
          style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 40)),
          child: Text(
            "CHANGE PASSWORD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

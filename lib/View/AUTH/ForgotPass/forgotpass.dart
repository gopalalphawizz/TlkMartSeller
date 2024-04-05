import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/AUTH/LOGIN/otpfind.dart';
import 'package:alpha_work/ViewModel/authViewModel.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final TextEditingController phoneCtrl = TextEditingController();
  late AuthViewModel auth;
  late ProfileViewModel profile;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height * .35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.onboardingBg_light))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Verify Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            Positioned(
              top: height * .07,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: height * .9,
                  width: width * .9,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * .15),
                        Image.asset(Images.alphalogo_light,
                            height: (height / width) * 35,
                            width: (height / width) * 35),
                        // const Divider(color: Colors.transparent),
                        Text(
                          "Enter your mobile number",
                          style: const TextStyle(fontSize: 28),
                        ),

                        Text(
                          "We will send you 4 digit verification code",
                          style: const TextStyle(
                              fontSize: 14, color: colors.greyText),
                        ),
                        const Divider(color: Colors.transparent),
                        TextFormField(
                          controller: phoneCtrl,
                          inputFormatters: [RegexFormatter.phone],
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(label: Text("Mobile No.")),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return "Enter a valid number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          onChanged: (value) {
                            if (value.length == 10) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print(phoneCtrl.text);
                                auth
                                    .forgetPassOtp(
                                        phone: phoneCtrl.text,
                                        context: context,
                                        resend: false,
                                        isPass: true)
                                    .then((value) => Navigator.push(
                                        context,
                                        PageTransition(
                                            child: OtpCheckPage(isPass: true),
                                            type:
                                                PageTransitionType.rightToLeft)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                            ),
                            child: Text(
                              "SEND",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

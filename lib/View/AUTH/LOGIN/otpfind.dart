import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/View/AUTH/ForgotPass/resetPass.dart';
import 'package:alpha_work/View/Profile/changePassword/changePassword.dart';
import 'package:alpha_work/ViewModel/authViewModel.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../Dashboard/Dashboad.dart';

class OtpCheckPage extends StatefulWidget {
  final bool isPass;

  const OtpCheckPage({super.key, required this.isPass});
  @override
  State<OtpCheckPage> createState() => _OtpCheckPageState();
}

class _OtpCheckPageState extends State<OtpCheckPage> {
  TextEditingController pinCtrl = TextEditingController();
  late String savedotp;
  late String mobile;
  late AuthViewModel auth;
  void getOtp() async {
    savedotp = PreferenceUtils.getString(PrefKeys.otp);
    mobile = PreferenceUtils.getString(PrefKeys.mobile);
    print(savedotp);
    print(mobile);
    setState(() {
      pinCtrl.text = savedotp;
    });
  }

  @override
  void initState() {
    auth = Provider.of<AuthViewModel>(context, listen: false);
    getOtp();

    super.initState();
  }

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 19, 88, 130),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  final focusedPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 19, 88, 130),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(Images.onboardingBg_light),
          AppBar(
            toolbarHeight: kToolbarHeight,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                Image.asset(width: 60, Images.alphalogo_light),
                const Text(
                  "Enter Verification Code",
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  "Enter the otp sent to ${mobile.toString()}",
                  style: TextStyle(fontSize: 14, color: colors.greyText),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 30,
                ),
                Center(
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    length: 4,
                    controller: pinCtrl,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (pinCtrl.text == savedotp && !widget.isPass) {
                      PreferenceUtils.setString(PrefKeys.isLoggedIn, "true");
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: const DashboardScreen1(),
                              type: PageTransitionType.rightToLeft),
                          (route) => false);
                    } else {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: ResetPasswordScreen(
                                  otp: savedotp, phone: mobile),
                              type: PageTransitionType.rightToLeft));
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A9494),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "VERIFY",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn`t receaved Otp? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (widget.isPass) {
                              print("dgfhjgf");
                              await auth
                                  .forgetPassOtp(
                                      phone: mobile,
                                      context: context,
                                      isPass: widget.isPass,
                                      resend: false)
                                  .then((value) => getOtp());
                            } else {
                              await auth
                                  .loginwithPhone(
                                      phone: mobile,
                                      context: context,
                                      isPass: widget.isPass,
                                      resend: false)
                                  .then((value) => getOtp());
                            }
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 29, 104, 136),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// OtpTextField(
//                   autoFocus: true,
//                   fieldWidth: 50,
//                   numberOfFields: 4,
//                   borderColor: const Color.fromARGB(255, 19, 88, 130),
//                   //set to true to show as box or false to show as dash
//                   showFieldAsBox: true,

//                   //runs when a code is typed in
//                   onCodeChanged: (String code) {
//                     code = otp;
//                   },
//                   //runs when every textfield is filled
//                   onSubmit: (String verificationCode) {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Verification Code"),
//                             content: Text('Code entered is $verificationCode'),
//                           );
//                         });
//                   }, // end onSubmit
//                 ),
            
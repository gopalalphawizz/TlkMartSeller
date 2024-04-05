import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/AUTH/ForgotPass/forgotpass.dart';
import 'package:alpha_work/ViewModel/authViewModel.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:regexed_validator/regexed_validator.dart';
import '../SIGNUP/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var tabstatus = 0;
  TextEditingController mobilenumbercontroller = TextEditingController();

  late AuthViewModel auth;
  @override
  void initState() {
    auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  int indx = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            child: Stack(
              children: [
                Container(
                  height: height * .35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.onboardingBg_light))),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: height,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Image.asset(Images.alphalogo_light,
                            height: (height / width) * 35,
                            width: (height / width) * 35),
                        Text(
                          AppLocalizations.of(context)!.signInToYourAccount,
                          style: const TextStyle(fontSize: 28),
                        ),
                        SizedBox(
                          width: width * .7,
                          child: Text(
                            "Effortless Access to Orders, Insights, and Customized Solutions",
                            style:
                                TextStyle(color: colors.greyText, fontSize: 14),
                          ),
                        ),
                        Divider(color: Colors.transparent),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                indx = 0;
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: indx == 0
                                      ? colors.buttonColor.withOpacity(0.3)
                                      : Colors.white,
                                ),
                                child: Text(
                                  "Login via Phone",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: indx == 0
                                        ? colors.buttonColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                indx = 1;
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: indx == 1
                                      ? colors.buttonColor.withOpacity(0.3)
                                      : Colors.white,
                                ),
                                child: Text(
                                  "Login via Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: indx == 1
                                        ? colors.buttonColor
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        indx == 0
                            ? PhoneLogin(auth: auth)
                            : EmailView(auth: auth),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const SignUpPage())));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don`t have an account?"),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colors.buttonColor,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              )),
                        ),
                        Divider(color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneLogin extends StatelessWidget {
  final AuthViewModel auth;
  final TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  PhoneLogin({super.key, required this.auth});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //key: _formKey,
        child: Column(
          children: [
            const Divider(color: Colors.transparent),
            TextFormField(
              controller: mobile,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration()
                  .applyDefaults(Theme.of(context).inputDecorationTheme)
                  .copyWith(
                    label: Text("Phone Number"),
                  ),
              keyboardType: TextInputType.number,
              maxLength: 10,

            ),
            const Divider(
              color: Colors.transparent,
            ),
            GestureDetector(
              onTap: () {

                FocusScope.of(context).unfocus();

                if (mobile.text == ""||mobile.text.length<10) {
                  Utils.showTost(msg: "Please enter valid mobile number.");
                } else {
                  print(mobile.text);
                  auth
                      .loginwithPhone(
                          phone: mobile.text,
                          context: context,
                          isPass: false,
                          resend: true)
                      .then((value) {});

                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A9494),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          child: ForgotPassForm(),
                          type: PageTransitionType.rightToLeft)),
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class EmailView extends StatefulWidget {
  const EmailView({super.key, required this.auth});
  final AuthViewModel auth;
  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  FocusNode passFocus = new FocusNode();
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Divider(color: Colors.transparent),
            TextFormField(
              controller: email,
              textInputAction: TextInputAction.next,
              inputFormatters: [RegexFormatter.email],
              decoration: InputDecoration()
                  .applyDefaults(Theme.of(context).inputDecorationTheme)
                  .copyWith(
                    label: Text("Email ID"),
                  ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter email";
                } else if (!validator.email(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              controller: pass,
              decoration: InputDecoration()
                  .applyDefaults(Theme.of(context).inputDecorationTheme)
                  .copyWith(
                      label: Text("Password"),
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          visibility = !visibility;
                          print("object");
                        }),
                        child: Icon(
                          visibility ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
              obscureText: visibility,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.auth.loginwithEmail(
                      email: email.text.toString(),
                      context: context,
                      pass: pass.text.toString());
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A9494),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          child: ForgotPassForm(),
                          type: PageTransitionType.rightToLeft)),
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

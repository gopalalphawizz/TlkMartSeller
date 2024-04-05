import 'package:alpha_work/Model/cityModel.dart';
import 'package:alpha_work/Model/countryModel.dart';
import 'package:alpha_work/Model/stateModel.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/AUTH/LOGIN/loginpage.dart';
import 'package:alpha_work/View/Profile/privacyPolicy/privacyPolicy.dart';
import 'package:alpha_work/View/Profile/termsCondition/termsCondition.dart';
import 'package:alpha_work/ViewModel/addressViewModel.dart';
import 'package:alpha_work/ViewModel/authViewModel.dart';
import 'package:alpha_work/Widget/DropdownDeco.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Utils/color.dart';
import '../../../Widget/CommonTextWidget/commontext.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int currentprogressstep = 1;
  bool isChecked = false;
  var activeStep = 0;
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController referalcodecontroller = TextEditingController();

  TextEditingController businesemail = TextEditingController();
  TextEditingController businesphoneNo = TextEditingController();
  TextEditingController busineType = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController businesRegNo = TextEditingController();
  TextEditingController businesGSTNIN = TextEditingController();
  TextEditingController businesTaxIDNM = TextEditingController();
  TextEditingController businesWebsite = TextEditingController();
  TextEditingController passwordsetup = TextEditingController();
  TextEditingController cnfrmPassword = TextEditingController();

  //for address information
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController postalcodecontroller = TextEditingController();

  // for banking information
  TextEditingController AccHolderName = TextEditingController();
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController bankbranchcontroller = TextEditingController();
  TextEditingController accounttypecontroller = TextEditingController();
  TextEditingController micrController = TextEditingController();
  TextEditingController bankaddresscontroler = TextEditingController();
  TextEditingController accountcontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();
  bool visibility = true;
  bool visibility1 = true;
  List<DropdownMenuItem> items = [
    DropdownMenuItem(
        child: Text(
          "Saving Account",
          style:
              TextStyle(color: colors.greyText, fontWeight: FontWeight.normal),
        ),
        value: "Saving Account"),
    DropdownMenuItem(
        child: Text(
          "Current Account",
          style:
              TextStyle(color: colors.greyText, fontWeight: FontWeight.normal),
        ),
        value: "Current Account"),
  ];
  late AuthViewModel auth;
  late String savedotp;
  late AddressViewModel addressP;
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

  void getOtp() async {
    savedotp = PreferenceUtils.getString(PrefKeys.otp);
    print(savedotp);

    setState(() {
      pinCtrl.text = savedotp;
    });
  }

  @override
  void initState() {
    auth = Provider.of<AuthViewModel>(context, listen: false);
    addressP = Provider.of<AddressViewModel>(context, listen: false);
    super.initState();
  }

  final defaultPinTheme = PinTheme(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    textStyle: TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 19, 88, 130),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  final focusedPinTheme = PinTheme(
    textStyle: TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 19, 88, 130),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  TextEditingController pinCtrl = TextEditingController();
  List<Widget> progressItem = [];
  double percent = 0.03;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        showDialog<void>(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                'Are you sure you want to leave',
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Nevermind'),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Leave'),
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Registration Onboarding",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          forceMaterialTransparency: true,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              if (activeStep != 0) {
                print(activeStep);
                if (activeStep == 2) {
                  progressItem.removeLast();
                  setState(() {
                    activeStep = activeStep - 2;
                    percent = 0.03;
                  });
                } else {
                  progressItem.removeLast();
                  setState(() {
                    activeStep--;
                    percent -= 0.166;
                  });
                }
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearPercentIndicator(
                  progressColor: colors.buttonColor,
                  percent: percent,
                  barRadius: Radius.circular(10),
                ),
                SizedBox(
                  width: width,
                  height: 30,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: progressItem,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.transparent, height: height * .02),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (activeStep == 0)
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Create your account",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Join us today and unlock exclusive benefits by creating your account now.",
                                    style: TextStyle(
                                      color: colors.greyText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .05,
                                  ),
                                  TextFormField(
                                    controller: mobilecontroller,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'\d+'))
                                    ],
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                          label: Text("Mobile No."),
                                          counterText: '',
                                        ),
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
                                  Divider(color: Colors.transparent),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        value: isChecked,
                                        activeColor: colors.buttonColor,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "By Continue, you agree to our",
                                            style: TextStyle(),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            TermsAndConditionScreen(),
                                                        type: PageTransitionType
                                                            .rightToLeft)),
                                                child: Text(
                                                  "Term of Services",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 16, 89, 132),
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text("&"),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            PrivacyPolicyScreen(),
                                                        type: PageTransitionType
                                                            .rightToLeft)),
                                                child: Text(
                                                  "Privacy Policy",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 16, 89, 132),
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.transparent),
                                  GestureDetector(
                                    onTap: isChecked
                                        ? () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                isChecked) {
                                              print(mobilecontroller.text);
                                              auth
                                                  .getRegistrarionOtp(
                                                      phone: mobilecontroller
                                                          .text
                                                          .toString())
                                                  .then((value) {
                                                if (value) {
                                                  getOtp();
                                                  setState(() {
                                                    activeStep++;
                                                  });
                                                }
                                              });
                                            }
                                          }
                                        : null,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width - 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: isChecked
                                              ? const Color(0xFF0A9494)
                                              : colors.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "VERIFY",
                                              style: TextStyle(
                                                  color: isChecked
                                                      ? Colors.white
                                                      : colors.lightTextColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (activeStep == 1)
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: Colors.transparent),
                                const Text(
                                  "Enter Verification Code",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  "Enter the otp sent to ${mobilecontroller.text.toString()}",
                                  style: TextStyle(
                                      fontSize: 14, color: colors.greyText),
                                ),
                                Divider(
                                    color: Colors.transparent,
                                    height: height * .05),
                                Pinput(
                                  defaultPinTheme: defaultPinTheme.copyWith(
                                    width: width * .2,
                                    height: 50,
                                  ),
                                  focusedPinTheme: focusedPinTheme.copyWith(
                                    width: width * .2,
                                    height: 50,
                                  ),
                                  length: 4,
                                  controller: pinCtrl,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (pinCtrl.text == savedotp &&
                                        savedotp.isNotEmpty) {
                                      progressItem.add(
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                size: 20,
                                                color: Colors.black),
                                            Text(
                                              "Phone",
                                              textAlign: TextAlign.center,
                                            ),
                                            VerticalDivider(
                                              color: Colors.transparent,
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                      setState(() {
                                        activeStep += 1;
                                        percent = 0.166;
                                        _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent);
                                      });
                                    } else if (savedotp.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "No OTP found",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: colors.buttonColor,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "OTP did not match!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: colors.buttonColor,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0A9494),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Didn`t receaved Otp? ",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            auth
                                                .getRegistrarionOtp(
                                                    phone: mobilecontroller.text
                                                        .toString())
                                                .then((value) => getOtp());
                                          },
                                          child: Text(
                                            "Resend OTP",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 29, 104, 136),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (activeStep == 2)
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SignupHeadingText(
                                    text: 'Enter personal detail',
                                  ),
                                  const Text(
                                    "Enter your personal details to create an account and unlock a world of possibilities",
                                    style: TextStyle(color: colors.greyText),
                                  ),
                                  SizedBox(height: height * .04),
                                  TextFormField(
                                    controller: namecontroller,
                                    keyboardType: TextInputType.name,
                                    maxLength: 21,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your name";
                                      } else if (value.length < 3) {
                                        return "Enter a valid name";
                                      }
                                      return null;
                                    },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                          labelText: "Full Name*",
                                          counterText: "",
                                        ),
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    controller: emailcontroller,
                                    textCapitalization: TextCapitalization.none,
                                    inputFormatters: [RegexFormatter.email],
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                          labelText: "Email ID*",
                                        ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter email";
                                      } else if (!validator.email(value)) {
                                        return "Please enter a valid email";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    maxLength: 10,
                                    enabled: false,
                                    controller: mobilecontroller,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            labelText: "Phone Number*",
                                            counterText: ""),
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: referalcodecontroller,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                          labelText: "Referral Code (Optional)",
                                        ),
                                  ),
                                  Divider(
                                    color: Colors.transparent,
                                    height: height * .1,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        progressItem.add(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Colors.black,
                                                  size: 20),
                                              Text(
                                                "Personal Info",
                                                textAlign: TextAlign.center,
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                        setState(() {
                                          activeStep += 1;
                                          percent += 0.166;
                                          _scrollController.jumpTo(
                                              _scrollController
                                                  .position.maxScrollExtent);
                                        });
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width - 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0A9494),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "CONTINUE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (activeStep == 3)
                          Container(
                            child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SignupHeadingText(
                                        text: 'Enter your Business detail',
                                      ),
                                      const Text(
                                        'Enter your business details to get started and unlock a world of opportunities.',
                                        style:
                                            TextStyle(color: colors.greyText),
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: businesemail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        inputFormatters: [RegexFormatter.email],
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              labelText: "Email ID*",
                                            ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter email";
                                          } else if (!validator.email(value)) {
                                            return "Please enter a valid email";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [RegexFormatter.phone],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter your phone";
                                          }
                                          return null;
                                        },
                                        maxLength: 10,
                                        keyboardType: TextInputType.phone,
                                        controller: businesphoneNo,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                                labelText: "Phone Number*",
                                                counterText: ""),
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: companyname,
                                        keyboardType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              labelText:
                                                  "Company or Business Name*",
                                            ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter business name";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: busineType,
                                        keyboardType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              labelText: "Business Type*",
                                            ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter business type";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: businesRegNo,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [RegexFormatter.regNo],
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        maxLength: 21,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Registration Number";
                                          } else if (value.length != 21) {
                                            return "Enter a valid registration number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              hintText: "21 Digit Registration",
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: colors.greyText,
                                                  ),
                                              counterText: "",
                                              labelText: "Registration Number*",
                                            ),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: businesGSTNIN,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        inputFormatters: [RegexFormatter.regNo],
                                        maxLength: 15,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                                labelText: "GSTIN (Optional)",
                                                counterText: ""),
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: businesTaxIDNM,
                                        inputFormatters: [RegexFormatter.regNo],
                                        maxLength: 10,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              counterText: "",
                                              labelText:
                                                  "Permanent Account Number (PAN)*",
                                            ),
                                        textInputAction: TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Permanent Account Number (PAN)*";
                                          } else if (value.length != 10) {
                                            return "Enter a valid PAN";
                                          }
                                          return null;
                                        },
                                      ),
                                      const Divider(color: Colors.transparent),
                                      TextFormField(
                                        controller: null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration()
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              labelText: "Website  (Optional)",
                                            ),
                                        textInputAction: TextInputAction.done,
                                      ),
                                      Divider(color: Colors.transparent),
                                      GestureDetector(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            progressItem.add(
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .check_circle_outline_rounded,
                                                      color: Colors.black,
                                                      size: 20),
                                                  Text(
                                                    "Business Info",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            );
                                            setState(() {
                                              activeStep += 1;
                                              percent += 0.166;
                                              _scrollController.jumpTo(
                                                  _scrollController.position
                                                      .maxScrollExtent);
                                            });
                                          }
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            // width: MediaQuery.of(context).size.width - 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0A9494),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "CONTINUE",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        if (activeStep == 4)
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SignupHeadingText(
                                    text: 'Enter new Password',
                                  ),
                                  const Text(
                                    "Set your password your new password so you can access alpha e-commerce",
                                    style: TextStyle(color: colors.greyText),
                                  ),
                                  SizedBox(
                                    height: height * .07,
                                  ),
                                  TextFormField(
                                    controller: pass,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            label: Text("New Password"),
                                            suffixIcon: GestureDetector(
                                              onTap: () => setState(() {
                                                visibility = !visibility;
                                                print("object");
                                              }),
                                              child: Icon(
                                                visibility
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            )),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: visibility,
                                    validator: (value) {
                                      return validatePassword(value);
                                    },
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    controller: pass1,
                                    decoration: InputDecoration()
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            label: Text("Confirm Password"),
                                            suffixIcon: GestureDetector(
                                              onTap: () => setState(() {
                                                visibility1 = !visibility1;
                                                print("object");
                                              }),
                                              child: Icon(
                                                visibility1
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            )),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: visibility1,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter password";
                                      }
                                      return null;
                                    },
                                  ),
                                  Divider(
                                    color: Colors.transparent,
                                    height: height * .07,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (pass.text == pass1.text) {
                                          progressItem.add(
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: Colors.black,
                                                    size: 20),
                                                Text(
                                                  "Create Password",
                                                  textAlign: TextAlign.center,
                                                ),
                                                VerticalDivider(
                                                  color: Colors.transparent,
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          );
                                          setState(() {
                                            activeStep += 1;
                                            percent += 0.166;
                                            _scrollController.jumpTo(
                                                _scrollController
                                                    .position.maxScrollExtent);
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Password did not match!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  colors.buttonColor,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0A9494),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "CREATE PASSWORD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (activeStep == 5)
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SignupHeadingText(
                                    text: 'Enter Your Address Information',
                                  ),
                                  const Text(
                                    'Unlock exclusive access! Complete your signup by adding your address details.',
                                    style: TextStyle(color: colors.greyText),
                                  ),
                                  SizedBox(
                                    height: height * .05,
                                  ),
                                  TextFormField(
                                    controller: addresscontroller,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "Address*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Address";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: DropDownDeco(ctx: context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Consumer<AddressViewModel>(
                                          builder: (context, val, _) {
                                        if (addressP.countries.length == 0) {
                                          addressP.getCountries();
                                        }
                                        return DropdownButton<CountyData>(
                                          underline: Container(),
                                          isExpanded: true,
                                          dropdownColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? colors.darkBG
                                                  : Colors.white,
                                          value: val.selectedCountry,
                                          onChanged: (value) {
                                            setState(() {
                                              val.setCountry(value!);

                                              val.getStates(
                                                  id: value.id.toString());
                                            });
                                          },
                                          items: addressP.countries
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(
                                                      e.name.toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    value: e,
                                                  ))
                                              .toList(),
                                          hint: Text('Select a country',
                                              style: TextStyle(
                                                  color: colors.greyText,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        );
                                      }),
                                    ),
                                  ),
                                  const Divider(color: Colors.transparent),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: DropDownDeco(ctx: context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Consumer<AddressViewModel>(
                                          builder: (context, val, _) {
                                        return DropdownButton<StateData>(
                                          underline: Container(),
                                          isExpanded: true,
                                          dropdownColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? colors.darkBG
                                                  : Colors.white,
                                          value: addressP.selectedState,
                                          onChanged: (value) {
                                            setState(() {
                                              val.set_State(value);

                                              val.getCities(
                                                  id: value!.id.toString());
                                            });
                                          },
                                          items: addressP.states
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(
                                                      e.name.toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    value: e,
                                                  ))
                                              .toList(),
                                          hint: Text('Select State',
                                              style: TextStyle(
                                                  color: colors.greyText,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        );
                                      }),
                                    ),
                                  ),
                                  const Divider(color: Colors.transparent),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: DropDownDeco(ctx: context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Consumer<AddressViewModel>(
                                          builder: (context, val, _) {
                                        return DropdownButton<CityData>(
                                          underline: Container(),
                                          isExpanded: true,
                                          dropdownColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? colors.darkBG
                                                  : Colors.white,
                                          value: val.selectedCity,
                                          onChanged: (value) {
                                            setState(() {
                                              val.setCity(value);
                                            });
                                          },
                                          items: addressP.cities
                                              .map((e) => DropdownMenuItem(
                                                    child: Text(
                                                      e.name.toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    value: e,
                                                  ))
                                              .toList(),
                                          hint: Text('Select City',
                                              style: TextStyle(
                                                  color: colors.greyText,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        );
                                      }),
                                    ),
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    controller: postalcodecontroller,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 6,
                                    inputFormatters: [RegexFormatter.phone],
                                    keyboardType: TextInputType.number,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            labelText: "Postal/zip code*",
                                            counterText: ""),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter zip";
                                      } else if (value.length != 6) {
                                        return "Please enter a valid zip code";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * .07),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          addressP.selectedCountry != null &&
                                          addressP.selectedState != null &&
                                          addressP.selectedCity != null) {
                                        progressItem.add(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Colors.black,
                                                  size: 20),
                                              Text(
                                                "Address Info",
                                                textAlign: TextAlign.center,
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                        setState(() {
                                          activeStep += 1;
                                          percent += 0.166;
                                          _scrollController.jumpTo(
                                              _scrollController
                                                  .position.maxScrollExtent);
                                        });
                                      } else {
                                        Utils.showTost(
                                            msg:
                                                "Some fields are missing, please check.");
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0A9494),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "CONTINUE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (activeStep == 6)
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SignupHeadingText(
                                    text: 'Enter Your banking Information',
                                  ),
                                  const Text(
                                    "Enter your banking information to get started and manage your finances hassle-free.",
                                    style: TextStyle(color: colors.greyText),
                                  ),
                                  SizedBox(height: height * .02),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: AccHolderName,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            labelText: "Account Holder Name*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Account Holder Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: banknamecontroller,
                                    // inputFormatters: [],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "Bank Name*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Bank Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: bankbranchcontroller,
                                    // inputFormatters: [RegexFormatter.bankName],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "Bank Branch*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Bank Branch";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  DropdownButtonFormField2(
                                      decoration: const InputDecoration()
                                          .applyDefaults(Theme.of(context)
                                              .inputDecorationTheme)
                                          .copyWith(
                                              contentPadding:
                                                  EdgeInsets.only(right: 10)),
                                      hint: Text("Account Type*",
                                          style: TextStyle(
                                              color: colors.greyText,
                                              fontWeight: FontWeight.normal)),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        selectedValue = value;
                                      },
                                      items: items),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: micrController,
                                    maxLength: 9,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.next,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(
                                            labelText: " MICR code*",
                                            counterText: ""),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter MICR code";
                                      } else if (value.length != 9) {
                                        return "Enter a valid MICR code";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: bankaddresscontroler,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "Bank address*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Bank address";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [RegexFormatter.phone],
                                    controller: accountcontroller,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "Account Number*"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Account Number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    inputFormatters: [RegexFormatter.regNo],
                                    controller: ifsccontroller,
                                    textInputAction: TextInputAction.done,
                                    decoration: (const InputDecoration())
                                        .applyDefaults(Theme.of(context)
                                            .inputDecorationTheme)
                                        .copyWith(labelText: "IFSC Code*"),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return "Please enter IFSC Code";
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const Divider(color: Colors.transparent),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          addressP.selectedCountry != null &&
                                          addressP.selectedState != null &&
                                          addressP.selectedCity != null &&
                                          selectedValue != null) {
                                        print(savedotp);
                                        print(namecontroller.text);
                                        print(emailcontroller.text);
                                        print(mobilecontroller.text);
                                        print(referalcodecontroller.text);
                                        print(businesemail.text);
                                        print(businesphoneNo.text);
                                        print(companyname.text);
                                        print(busineType.text);
                                        print(businesRegNo.text);
                                        print(businesGSTNIN.text);
                                        print(businesTaxIDNM.text);
                                        print(businesWebsite.text);
                                        print(pass.text);
                                        print(pass1.text);
                                        print(addresscontroller.text);
                                        print(addressP.selectedCountry?.name);
                                        print(addressP.selectedState?.name);
                                        print(addressP.selectedCity?.name);
                                        print(postalcodecontroller.text);
                                        print(AccHolderName.text);
                                        print(banknamecontroller.text);
                                        print(bankbranchcontroller.text);
                                        print(selectedValue);
                                        print(micrController.text);
                                        print(bankaddresscontroler.text);
                                        print(accountcontroller.text);
                                        print(ifsccontroller.text);

                                        auth
                                            .registerUser(
                                          phone:
                                              mobilecontroller.text.toString(),
                                          otp: savedotp.toString(),
                                          name: namecontroller.text.toString(),
                                          email:
                                              emailcontroller.text.toString(),
                                          referalcode:
                                              referalcodecontroller.text.isEmpty
                                                  ? ""
                                                  : referalcodecontroller.text
                                                      .toString(),
                                          businessemail:
                                              businesemail.text.toString(),
                                          businessphoneNo:
                                              businesphoneNo.text.toString(),
                                          businessname:
                                              companyname.text.toString(),
                                          businessType:
                                              busineType.text.toString(),
                                          registrationNo:
                                              businesRegNo.text.toString(),
                                          gstin: businesGSTNIN.text.toString(),
                                          tin: businesTaxIDNM.text.toString(),
                                          website: businesWebsite.text.isEmpty
                                              ? ""
                                              : businesWebsite.text.toString(),
                                          password: pass.text.toString(),
                                          confirmPass: pass1.text.toString(),
                                          addr:
                                              addresscontroller.text.toString(),
                                          city: addressP.selectedCity!.name
                                              .toString(),
                                          state: addressP.selectedState!.name
                                              .toString(),
                                          zip: postalcodecontroller.text
                                              .toString(),
                                          country: addressP
                                              .selectedCountry!.name
                                              .toString(),
                                          AccHolderName:
                                              AccHolderName.text.toString(),
                                          bankName: banknamecontroller.text
                                              .toString(),
                                          branch: bankbranchcontroller.text
                                              .toString(),
                                          accType: selectedValue.toString(),
                                          micr: micrController.text.toString(),
                                          bankAddr: bankaddresscontroler.text
                                              .toString(),
                                          accNo:
                                              accountcontroller.text.toString(),
                                          ifsc: ifsccontroller.text.toString(),
                                        )
                                            .then((value) {
                                          if (value.status!) {
                                            showDialog(
                                              context: context,
                                              builder: (dCtx) {
                                                Future.delayed(
                                                    Duration(seconds: 3), () {
                                                  Navigator.of(dCtx).pop(true);
                                                });
                                                return RegistrationSuccessDialog(
                                                    dCtx);
                                              },
                                            ).then((value) =>
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage(),
                                                    ),
                                                    (route) => false));
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: value.errors[0]['message']
                                                  .toString(),
                                              backgroundColor:
                                                  colors.buttonColor,
                                              gravity: ToastGravity.BOTTOM,
                                              textColor: Colors.white,
                                              fontSize: 14,
                                            );
                                          }
                                        });
                                      } else {
                                        Utils.showTost(
                                            msg: "Some fields are missing");
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0A9494),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        "FINISH",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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

RegistrationSuccessDialog(BuildContext context) {
  return Material(
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.success_bg), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            Images.success_check,
            height: 100,
            width: 100,
          ),
          Divider(color: Colors.transparent),
          Center(
            child: Text(
              "Request successfully send to admin",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Divider(color: Colors.transparent),
          Center(
            child: Text(
              "Please wait for confirmation",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    ),
  );
}

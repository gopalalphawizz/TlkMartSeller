import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class EditBusinessDetailScreen extends StatefulWidget {
  final VendorData vendorData;

  EditBusinessDetailScreen({super.key, required this.vendorData});

  @override
  State<EditBusinessDetailScreen> createState() =>
      _EditBusinessDetailScreenState();
}

class _EditBusinessDetailScreenState extends State<EditBusinessDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController gstinCtrl = TextEditingController();
  final TextEditingController regCtrl = TextEditingController();
  final TextEditingController tinCtrl = TextEditingController();
  late ProfileViewModel profilePro;
  @override
  void initState() {
    emailCtrl.text = widget.vendorData.shop!.email.toString();
    typeCtrl.text = widget.vendorData.shop!.bussinessType.toString();
    nameCtrl.text = widget.vendorData.shop!.name.toString();
    gstinCtrl.text = widget.vendorData.shop!.gstIn.toString();
    regCtrl.text = widget.vendorData.shop!.registerationNumber.toString();
    tinCtrl.text = widget.vendorData.shop!.taxIdentificationNumber.toString();
    profilePro = Provider.of<ProfileViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Business Detail"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailCtrl,
                  inputFormatters: [RegexFormatter.email],
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Email ID"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Email ID";
                    } else if (!validator.email(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: typeCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Business Type*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter businesss type";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Company or Business Name*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Company or Business Name*";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: gstinCtrl,
                  inputFormatters: [RegexFormatter.regNo],
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 15,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Enter GSTIN", counterText: ""),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Please enter GSTIN";
                  //   }
                  //   if (value.length < 15) {
                  //     return "Please enter valid GST";
                  //   }
                  //   return null;
                  // },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: regCtrl,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [RegexFormatter.regNo],
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 21,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Registration No.";
                    }
                    if (value.length < 21) {
                      return "Please enter valid Reg No.";
                    }
                    return null;
                  },
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                          labelText:
                              "Business Registration Number (if applicable)",
                          counterText: ""),
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: tinCtrl,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [RegexFormatter.regNo],
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 10,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                          labelText: "Permanent Account Number (PAN)*",
                          counterText: ""),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Permanent Account Number";
                    }
                    if (value.length < 10) {
                      return "Please enter Permanent Account Number";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await profilePro
                            .updateBusinessDetail(
                              bussiness_email_id: emailCtrl.text.toString(),
                              bussiness_type: typeCtrl.text.toString(),
                              company_name: nameCtrl.text.toString(),
                              gst_in: gstinCtrl.text.toString().toUpperCase(),
                              bussiness_registeration_number:
                                  regCtrl.text.toString().toUpperCase(),
                              tax_identification_number:
                                  tinCtrl.text.toString().toUpperCase(),
                            )
                            .then(
                              (value) => Fluttertoast.showToast(
                                msg: value['msg'],
                                backgroundColor: colors.buttonColor,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                              ),
                            );
                        await profilePro
                            .getvendorProfileData()
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .9, 50)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

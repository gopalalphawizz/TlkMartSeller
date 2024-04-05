import 'dart:io';

import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class EditStoreDetailScreen extends StatefulWidget {
  EditStoreDetailScreen({super.key, required this.vendor});
  final VendorData vendor;
  @override
  State<EditStoreDetailScreen> createState() => _EditStoreDetailScreenState();
}

class _EditStoreDetailScreenState extends State<EditStoreDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late ProfileViewModel profilePro;
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController reg = TextEditingController();
  final TextEditingController gstin = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController social = TextEditingController();
  final TextEditingController taxid = TextEditingController();

  String? image;
  File? _image;
  bool isFromFile = false;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print(pickedFile!.path.toString());
    image = pickedFile.path.toString();
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      image = pickedFile.path.toString();
    }
    setState(() {
      isFromFile = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.vendor.shop!.name.toString();
    desc.text = widget.vendor.shop!.details.toString();
    type.text = widget.vendor.shop!.bussinessType.toString();
    reg.text = widget.vendor.shop!.registerationNumber.toString();
    gstin.text = widget.vendor.shop!.gstIn.toString();
    email.text = widget.vendor.shop!.email.toString();
    website.text = widget.vendor.shop!.websiteLink.toString();
    social.text = widget.vendor.shop!.socialLink.toString();
    taxid.text = widget.vendor.shop!.taxIdentificationNumber.toString();
    profilePro = Provider.of<ProfileViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Store Detail"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isFromFile
                    ? CircleAvatar(
                        radius: (height / width) * 30,
                        backgroundImage: FileImage(_image!),
                        onBackgroundImageError: (exception, stackTrace) =>
                            ErrorImageWidget(height: height),
                        backgroundColor: colors.buttonColor.withOpacity(0.2),
                      )
                    : CircleAvatar(
                        radius: (height / width) * 30,
                        backgroundImage:
                            NetworkImage(widget.vendor.shop!.image.toString()),
                        onBackgroundImageError: (exception, stackTrace) =>
                            ErrorImageWidget(height: height),
                        backgroundColor: colors.buttonColor.withOpacity(0.2),
                      ),
                const Divider(color: Colors.transparent),
                TextButton.icon(
                    onPressed: () => getImageFromGallery(),
                    style: TextButton.styleFrom(
                        backgroundColor: colors.buttonColor),
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Edit Image",
                      style: TextStyle(color: Colors.white),
                    )),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: name,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Store Name*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Store Name";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                SizedBox(
                  height: height * .1,
                  child: TextFormField(
                    controller: desc,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    decoration: (const InputDecoration())
                        .applyDefaults(Theme.of(context).inputDecorationTheme)
                        .copyWith(labelText: "Description"),
                  ),
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: type,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Business Type*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter business type";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: reg,
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
                  controller: gstin,
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
                  controller: taxid,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [RegexFormatter.regNo],
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                          labelText: "Tax Identification*", counterText: ""),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter TIN";
                    }
                    if (value.length < 10) {
                      return "Please enter valid TIN";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Email ID*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email ID";
                    } else if (!validator.email(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: website,
                  textInputAction: TextInputAction.done,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Website"),
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: social,
                  textInputAction: TextInputAction.next,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Social Media Links"),
                ),
                const Divider(color: Colors.transparent),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(image);
                        profilePro
                            .updateStoreDetail(
                          isFromFile: isFromFile,
                          name: name.text.toString(),
                          email: email.text.toString(),
                          desc: desc.text.toString(),
                          imageUrl: image.toString(),
                          type: type.text.toString(),
                          reg: reg.text.toString(),
                          gst: gstin.text.toString(),
                          tax: taxid.text.toString(),
                          website: website.text.toString(),
                          social: social.text.toString(),
                        )
                            .then((value) async {
                          Utils.showTost(msg: value['msg']);
                          await profilePro.getvendorProfileData();
                          Navigator.pop(context);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .9, 50)),
                    child: Text(
                      "EDIT STORE DETAIL",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Divider(color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

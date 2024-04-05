import 'dart:io';

import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:alpha_work/Widget/fieldFormatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.vendorData});
  final VendorData vendorData;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  late ProfileViewModel profilePro;
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
    nameCtrl.text =
        "${widget.vendorData.fName.toString().toUpperCase()} ${widget.vendorData.lName.toString().toUpperCase()}";
    emailCtrl.text = widget.vendorData.email.toString();
    phoneCtrl.text = widget.vendorData.phone.toString();
    image = widget.vendorData.image.toString();
    profilePro = Provider.of<ProfileViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Edit Profile"),
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
                        radius: height * .08,
                        backgroundImage: FileImage(_image!),
                        onBackgroundImageError: (exception, stackTrace) =>
                            ErrorImageWidget(height: height * .1),
                      )
                    : CircleAvatar(
                        radius: height * .08,
                        backgroundImage: NetworkImage(
                          widget.vendorData.image.toString(),
                        ),
                        onBackgroundImageError: (exception, stackTrace) =>
                            ErrorImageWidget(height: height * .1),
                      ),
                const SizedBox(height: 5),
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
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.characters,
                  controller: nameCtrl,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Full Name*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Full Name";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCtrl,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(labelText: "Personal Email ID*"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Personal Email ID";
                    } else if (!validator.email(value)) {
                      return "Please enter valid email id";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  enabled: false,
                  inputFormatters: [RegexFormatter.phone],
                  maxLength: 10,
                  controller: phoneCtrl,
                  decoration: (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                          labelText: "Personal Phone Number*", counterText: ''),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Phone Number";
                    }
                    return null;
                  },
                ),
                const Divider(color: Colors.transparent),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              print(image);
              await profilePro
                  .updateProfileDetail(
                      name: nameCtrl.text.toString(),
                      email: emailCtrl.text.toString(),
                      phone: phoneCtrl.text.toString(),
                      isFromFile: isFromFile,
                      imageUrl: image.toString())
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
          style: ElevatedButton.styleFrom(fixedSize: Size(width * .9, 50)),
          child: Text(
            "SAVE",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

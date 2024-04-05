import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Profile/profile/addressInfo.dart';
import 'package:alpha_work/View/Profile/profile/bankingInfo.dart';
import 'package:alpha_work/View/Profile/profile/businessDetail.dart';
import 'package:alpha_work/View/Profile/profile/editProfile.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel pro;
  @override
  void initState() {
    pro = Provider.of<ProfileViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    pro = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: height * .35,
            decoration: BoxDecoration(
              color: colors.buttonColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    Images.profile_bg_circle,
                    height: height * .22,
                  ),
                ),
                Positioned(
                  top: 1,
                  child: SizedBox(
                    width: width,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      leading: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      centerTitle: true,
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      actions: [
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    child: EditProfileScreen(
                                        vendorData: pro.vendorData),
                                    type: PageTransitionType.rightToLeft)),
                            child: Image.asset(
                              Images.edit_button,
                              height: 22,
                              width: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // top: height * .13,
                  right: width * .1,
                  left: width * .1,
                  bottom: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (dctx) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: CachedNetworkImage(
                              imageUrl: pro.vendorData.image.toString(),
                            ),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: (height / width) * 25,
                          backgroundImage: CachedNetworkImageProvider(
                            pro.vendorData.image.toString(),
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              ErrorImageWidget(height: 90),
                        ),
                      ),
                      Text(
                        "${pro.vendorData.fName.toString().toUpperCase()} ${pro.vendorData.lName.toString().toUpperCase()}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_rounded,
                            color: colors.lightGrey,
                            size: 14,
                          ),
                          const VerticalDivider(
                              color: Colors.transparent, width: 2),
                          Text(
                            pro.vendorData.email.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: colors.lightGrey,
                            size: 14,
                          ),
                          const VerticalDivider(
                              color: Colors.transparent, width: 2),
                          Text(
                            pro.vendorData.phone.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.lightGrey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.transparent),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    child: EditBusinessDetailScreen(vendorData: pro.vendorData),
                    type: PageTransitionType.rightToLeft)),
            child: ListTile(
              dense: true,
              leading: Image.asset(
                Images.document,
                height: height * .04,
              ),
              title: Text(
                "Business Detail",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Divider(color: colors.lightGrey),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    child: EditAddressDetailScreen(vendorData: pro.vendorData),
                    type: PageTransitionType.rightToLeft)),
            child: ListTile(
              dense: true,
              leading: Image.asset(
                Images.locaction,
                height: height * .04,
              ),
              title: Text(
                "Address Information",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Divider(color: colors.lightGrey),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    child: EditBankingDetailScreen(vendorData: pro.vendorData),
                    type: PageTransitionType.rightToLeft)),
            child: ListTile(
              dense: true,
              leading: Image.asset(
                Images.paper,
                height: height * .04,
              ),
              title: Text(
                "Banking Information",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Divider(color: colors.lightGrey),
        ],
      ),
    );
  }
}

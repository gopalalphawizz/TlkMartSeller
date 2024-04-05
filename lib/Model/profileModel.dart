import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Profile/Advertising/advertRequest.dart';
import 'package:alpha_work/View/Profile/Advertising/advertising.dart';
import 'package:alpha_work/View/Profile/Faq/faq.dart';
import 'package:alpha_work/View/Profile/aboutUs/aboutus.dart';
import 'package:alpha_work/View/Profile/privacyPolicy/privacyPolicy.dart';
import 'package:alpha_work/View/Profile/referEarn/referEarn.dart';
import 'package:alpha_work/View/Profile/subscription/subscription.dart';
import 'package:alpha_work/View/Profile/support/queryList.dart';
import 'package:alpha_work/View/Profile/termsCondition/termsCondition.dart';
import 'package:alpha_work/View/Profile/changePassword/changePassword.dart';

class ProfileList {
  String profileIcon;
  String profileText;
  dynamic navigationScreen;
  ProfileList(
      {required this.profileIcon,
      required this.profileText,
      required this.navigationScreen});
}

List<ProfileList> profileItem = [
  ProfileList(
      profileIcon: Images.referAndEarn,
      profileText: 'Refer and Earn',
      navigationScreen: const ReferAndEarnScreen()),
  // ProfileList(
  //     profileIcon: Images.subscribe,
  //     profileText: 'Subscription',
  //     navigationScreen: const SubscriptionScreen()),
  ProfileList(
      profileIcon: Images.support,
      profileText: 'Customer Support',
      navigationScreen: const QueryListScreen()),
  ProfileList(
      profileIcon: Images.terms,
      profileText: 'Terms and Conditions',
      navigationScreen: const TermsAndConditionScreen()),
  ProfileList(
      profileIcon: Images.privacyPolicy,
      profileText: 'Privacy Policy',
      navigationScreen: PrivacyPolicyScreen()),
  ProfileList(
      profileIcon: Images.faq,
      profileText: 'FAQs',
      navigationScreen: const FaqScreen()),
  // ProfileList(
  //     profileIcon: Images.speaker,
  //     profileText: 'Adverting',
  //     navigationScreen: const AdvertRequestScreen()),
  ProfileList(
      profileIcon: Images.document,
      profileText: 'About Us',
      navigationScreen: AboutUsScreen()),
  // ProfileList(
  //     profileIcon: Images.currency,
  //     profileText: 'Currency',
  //     navigationScreen: ""),
  ProfileList(
      profileIcon: Images.changePassword,
      profileText: 'Change Password',
      navigationScreen: ChangePasswordScreen()),

  ProfileList(
      profileIcon: Images.logOut, profileText: 'Logout', navigationScreen: ""),
  ProfileList(
      profileIcon: Images.deactivate,
      profileText: 'Delete Account',
      navigationScreen: ""),
];

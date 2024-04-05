import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Profile/Advertising/selectpayment.dart';
import 'package:alpha_work/View/Profile/Advertising/uploadBanner.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AdvertisingScreen extends StatefulWidget {
  const AdvertisingScreen({super.key});

  @override
  State<AdvertisingScreen> createState() => _AdvertisingScreenState();
}

class _AdvertisingScreenState extends State<AdvertisingScreen> {
  late ProfileViewModel profilePro;
  @override
  void initState() {
    profilePro = Provider.of<ProfileViewModel>(context, listen: false);
    profilePro.getAdvertData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    profilePro = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Advertising"),
      body: profilePro.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView.builder(
                itemCount: profilePro.adverts.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          // child: SelectPaymentScreen(
                          //   amount: profilePro.adverts[index].amount!,
                          //   heading: profilePro.adverts[index].title!,
                          //   adId: profilePro.adverts[index].id.toString(),
                          // ),
                          child: UploadBannerScreen(
                            amount: profilePro.adverts[index].amount!,
                            heading: profilePro.adverts[index].title!,
                            adId: profilePro.adverts[index].id.toString(),
                          ),
                          type: PageTransitionType.rightToLeft)),
                  child: Container(
                    // height: height * .3,
                    padding: const EdgeInsets.only(bottom: 16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: colors.lightBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            profilePro.adverts[index].image.toString(),
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) =>
                                ErrorImageWidget(height: height * .1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                profilePro.adverts[index].title.toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                profilePro.adverts[index].amountWithCurrency
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montreal'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            profilePro.adverts[index].description.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.greyText,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

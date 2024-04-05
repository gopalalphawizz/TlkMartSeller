import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/View/Profile/Advertising/advertising.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AdvertRequestScreen extends StatefulWidget {
  const AdvertRequestScreen({super.key});

  @override
  State<AdvertRequestScreen> createState() => _AdvertRequestScreenState();
}

class _AdvertRequestScreenState extends State<AdvertRequestScreen> {
  late ProfileViewModel provider;
  @override
  void initState() {
    provider = Provider.of<ProfileViewModel>(context, listen: false);
    provider.getAdsStatus();
    print(provider.adsRequests.length);
    super.initState();
  }

  getColor(String status) {
    switch (status) {
      case "0":
        return Colors.orange;
      case "1":
        return Colors.green;
      case "2":
        return Colors.black;
      case "3":
        return Colors.red;

      default:
        null;
    }
  }

  getText(String status) {
    switch (status) {
      case "0":
        return "Pending";
      case "1":
        return "Accepetd";
      case "2":
        return "Completed";
      case "3":
        return "Declined";

      default:
        null;
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: CommanAppbar(appbarTitle: "Advertisement Request"),
      backgroundColor: Colors.white,
      body: provider.isLoading
          ? appLoader()
          : provider.adsRequests.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(),
                      SvgPicture.asset('assets/svg/advert.svg'),
                      Text(
                        "Request for \nAdvertainment to Admin",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 24,
                            ),
                      ),
                      const Divider(color: Colors.transparent),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: AdvertisingScreen(),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: Text(
                            "Request for Advertainment",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: provider.adsRequests.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.height * .08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: provider.adsRequests[index].image
                                      .toString(),
                                  errorWidget: (context, url, error) =>
                                      ErrorImageWidget(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .07),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const VerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      provider.adsRequests[index].advertisement!
                                          .title
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 18)),
                                  Text(
                                    provider.adsRequests[index].amount
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: getColor(provider
                                          .adsRequests[index].status
                                          .toString())
                                      .withOpacity(0.3),
                                ),
                                child: Text(
                                  getText(provider.adsRequests[index].status
                                      .toString()),
                                  style: TextStyle(
                                      color: getColor(provider
                                          .adsRequests[index].status
                                          .toString())),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.transparent),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Transactiobn ID"),
                                  Text(
                                    provider.adsRequests[index].transactionId
                                        .toString(),
                                    style: TextStyle(
                                      color: colors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Start Date"),
                                  Text(
                                    CustomDateFormat.formatDateOnly(provider
                                        .adsRequests[index].startDate
                                        .toString()),
                                    style: TextStyle(
                                      color: colors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      bottomNavigationBar: provider.adsRequests.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: AdvertisingScreen(),
                            type: PageTransitionType.rightToLeft));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  child: Text(
                    "Request for Advertisement",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          : null,
    );
  }
}

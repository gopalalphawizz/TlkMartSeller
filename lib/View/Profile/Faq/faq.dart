import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late ProfileViewModel provider;
  @override
  void initState() {
    provider = Provider.of<ProfileViewModel>(context, listen: false);
    provider.getStaticPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "FAQs"),
      body: provider.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.transparent),
                itemCount: provider.staticPageData.faq.length,
                itemBuilder: (context, index) => ExpansionTile(
                  title: Text(
                    provider.staticPageData.faq[index].question.toString(),
                    style: TextStyle(fontSize: 14, fontFamily: 'Montreal'),
                  ),
                  backgroundColor: colors.lightGrey,
                  collapsedBackgroundColor: colors.lightGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  expandedAlignment: Alignment.topLeft,
                  childrenPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.staticPageData.faq[index].answer.toString(),
                      style: TextStyle(
                          fontFamily: 'Montreal', color: colors.greyText),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
      appBar: CommanAppbar(appbarTitle: "About Us"),
      body: provider.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                  child: HtmlWidget(
                provider.staticPageData.aboutUs.toString(),
              )),
            ),
    );
  }
}

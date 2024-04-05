import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
      appBar: CommanAppbar(appbarTitle: "Terms and Condition"),
      body: provider.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  provider.staticPageData.termsNConditions!.content.toString(),
                ),
              ),
            ),
    );
  }
}

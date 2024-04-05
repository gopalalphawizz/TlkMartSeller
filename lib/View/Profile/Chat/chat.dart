import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  List<Map<String, dynamic>> chatList = [
    {
      'chat': "Hi",
      'isSender': true,
    },
    {
      'chat': "Hello",
      'isSender': false,
    },
    {
      'chat': "How can i help you?",
      'isSender': false,
    },
  ];
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Chat With Us"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.transparent,
          ),
          shrinkWrap: true,
          controller: scrollController,
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return BubbleSpecialOne(
              color: colors.buttonColor,
              isSender: chatList[index]['isSender'],
              text: chatList[index]['chat'].toString(),
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: width * .9,
        child: TextField(
          decoration: InputDecoration()
              .applyDefaults(Theme.of(context).inputDecorationTheme)
              .copyWith(
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: colors.greyText,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: colors.buttonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: ImageIcon(
                        AssetImage(Images.shareApp),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  hintText: "Type Message",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: colors.greyText,
                    fontWeight: FontWeight.w500,
                  )),
        ),
      ),
    );
  }
}

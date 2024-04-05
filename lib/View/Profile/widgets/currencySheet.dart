import 'package:alpha_work/Utils/color.dart';
import 'package:flutter/material.dart';

class CurrencyBottomSheet extends StatefulWidget {
  const CurrencyBottomSheet({super.key});

  @override
  State<CurrencyBottomSheet> createState() => _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends State<CurrencyBottomSheet> {
  int selectedCurrency = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 12, right: 12),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Text(
            "Change Currency",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.transparent),
          TextField(
            decoration: InputDecoration()
                .applyDefaults(Theme.of(context).inputDecorationTheme)
                .copyWith(
                    hintText: "Search",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500),
                    prefixIcon: Icon(Icons.search, color: Colors.black)),
          ),
          Divider(color: Colors.transparent),
          SizedBox(
            height: height * .4,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() {
                  selectedCurrency = index;
                }),
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Currency Data",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: selectedCurrency == index
                      ? Icon(
                          Icons.check,
                          color: colors.buttonColor,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

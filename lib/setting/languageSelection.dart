import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color.dart';
import '../Model/language.dart';
import '../ViewModel/languageViewModel.dart';

class LanguageWidget extends StatefulWidget {
  final String label;
  final LanguageModel model;
  const LanguageWidget({super.key, required this.label, required this.model});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  String selectedValue = '';
  List<Datum> languageList = [];
  final ValueNotifier<List<Datum>> selected = ValueNotifier<List<Datum>>([]);

  @override
  void initState() {
    languageList = widget.model.data;
    print("Languages length" '${languageList.length}');

    selected.value.addAll(languageList);
    selectedValue = languageList[0].name;
    print("${languageList.length}Language list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LanguageViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: const TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onChanged: (value) {
            if (value == '') {
              selected.value = [];
              selected.value.addAll(languageList);
            } else {
              selected.value = [];
              for (var i = 0; i < languageList.length; i++) {
                if (languageList[i]
                    .name
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
                  selected.value.add(languageList[i]);
                }
              }
            }
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            hintText: 'Search',
            hintStyle:
                const TextStyle(color: colors.lightTextColor, fontSize: 16),
            prefixIcon: const Icon(
              Icons.search,
              color: colors.lightTextColor,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: colors.textFieldColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: colors.textFieldColor, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: colors.textFieldColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: colors.textFieldColor, width: 1)),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
          valueListenable: selected,
          builder: (context, value, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: selected.value.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedValue = selected.value[index].name;
                        // SharedPref.shared.pref?.setString(
                        //     PrefKeys.selectedLanguageID,
                        //     selected.value[index].id);
                        languageModel.setLanguage(selected.value[index].name,
                            context, Locale(selected.value[index].code, ""));
                      });
                    },
                    title: Text(
                      selected.value[index].name,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    trailing: selected.value[index].name == selectedValue
                        ? const Icon(
                            Icons.check,
                            color: colors.lightButton,
                          )
                        : Container(
                            width: 0,
                          ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../ViewModel/currencyViewModel.dart';
import '../../ViewModel/languageViewModel.dart';
import '../../Widget/appLoader.dart';
import '../../Widget/selectluanguage.dart';
import '../../setting/languageSelection.dart';
import '../Curency/currecyselection.dart';
import 'package:provider/provider.dart';

class launguageSelection extends StatefulWidget {
  const launguageSelection({super.key});

  @override
  State<launguageSelection> createState() => _launguageSelectionState();
}

class _launguageSelectionState extends State<launguageSelection> {
  List<Map<String, dynamic>> languagelist = [
    {
      'id': 1,
      'name': 'English',
    },
    {
      'id': 2,
      'name': 'Hindi',
    },
    {
      'id': 3,
      'name': 'Italian',
    },
    {
      'id': 4,
      'name': 'Bangla',
    }
  ];

  final ValueNotifier<List> selected = ValueNotifier<List>([]);
  String selectedValue = '';
  late LanguageViewModel languageModel;
  late CurrencyViewModel currencyViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selected.value.addAll(languagelist);
    // selectedValue = languagelist[0]['name'];

    languageModel = Provider.of<LanguageViewModel>(context, listen: false);
    currencyViewModel = Provider.of<CurrencyViewModel>(context, listen: false);
    languageModel.getLanguages(context);

    print("Language model");
    // print(languageModel.model);
    currencyViewModel.getCurrencies(context);
  }

  @override
  Widget build(BuildContext context) {
    var languageModel = Provider.of<LanguageViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SelectionCurrencyWidget(
                              signIn: true,
                            ))));
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SelectionCurrencyWidget(
                              signIn: true,
                            ))));
              },
              icon: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: languageModel.isLoading
              ? appLoader()
              : LanguageWidget(
                  label: "Choose your Language",
                  model: languageModel.model,
                ),
        ),
      ),
    );
  }
}

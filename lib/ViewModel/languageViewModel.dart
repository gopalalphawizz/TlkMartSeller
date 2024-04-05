import 'package:flutter/material.dart';

import '../Model/language.dart';
import '../Utils/appUrls.dart';
import '../main.dart';
import '../repository/languageRepository.dart';

class LanguageViewModel with ChangeNotifier {
  final _myRepo = LangugageRepository();

  String _language = "";

  get language => _language;

  setLanguage(String language, BuildContext context, Locale newLocale) {
    _language = language;

    // MyApp.setLocale(context, newLocale);
    notifyListeners();
  }

  bool isLoading = false;

  bool get loading => isLoading;

  late LanguageModel model;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getLanguages(BuildContext context) async {
    setLoading(true);

    return await _myRepo.languageListRequest(AppUrl.languages).then((value) {
      model = value;

      print(value.message);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }
}

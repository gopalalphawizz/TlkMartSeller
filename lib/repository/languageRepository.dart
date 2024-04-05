import 'package:http/http.dart' as http;

import '../Model/language.dart';

class LangugageRepository {
  Future<LanguageModel> languageListRequest(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(
      url,
    );

    return languageModelFromJson(res.body);
  }
}

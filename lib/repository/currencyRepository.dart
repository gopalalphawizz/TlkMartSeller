import 'package:http/http.dart' as http;

import '../Model/currencyModel.dart';

class CurrencyRepository {
  Future<CurrencyModel> currencyListRequest(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(
      url,
    );

    return currencyModelFromJson(res.body);
  }
}

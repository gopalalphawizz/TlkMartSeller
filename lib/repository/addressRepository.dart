import 'dart:convert';

import 'package:alpha_work/Model/cityModel.dart';
import 'package:alpha_work/Model/countryModel.dart';
import 'package:alpha_work/Model/stateModel.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressRepository {
  Future<CountryModel> countryList({
    required String api,
  }) async {
    try {
      final url = Uri.parse(api);

      print(api);
      final http.Response res;
      res = await http.get(
        url,
      );

      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return CountryModel.fromJson(jsonData);
      } else {
        print(res.reasonPhrase);
        return CountryModel.fromJson(jsonData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<StateModel> StateList({
    required String api,
    required String countryId,
  }) async {
    try {
      final url =
          Uri.parse(api).replace(queryParameters: {'country_id': countryId});

      print(api);
      final http.Response res;
      res = await http.get(
        url,
      );

      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return StateModel.fromJson(jsonData);
      } else {
        print(res.reasonPhrase);
        return StateModel.fromJson(jsonData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CityModel> CityList({
    required String api,
    required String StateId,
  }) async {
    try {
      final url =
          Uri.parse(api).replace(queryParameters: {'state_id': StateId});

      print(api);
      final http.Response res;
      res = await http.get(
        url,
      );

      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return CityModel.fromJson(jsonData);
      } else {
        print(res.reasonPhrase);
        return CityModel.fromJson(jsonData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'package:alpha_work/Model/cityModel.dart';
import 'package:alpha_work/Model/countryModel.dart';
import 'package:alpha_work/Model/stateModel.dart';
import 'package:alpha_work/Utils/appUrls.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/repository/addressRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressViewModel with ChangeNotifier {
  final AddressRepository _myRepo = AddressRepository();
  bool isLoading = true;
  CountyData? selectedCountry;
  StateData? selectedState;
  CityData? selectedCity;
  setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setCountry(CountyData? value) {
    selectedCountry = value;
    print('country${selectedCountry!.name}');
    selectedState = null;
    states.clear();
    selectedCity = null;
    cities.clear();
    notifyListeners();
  }

  set_State(StateData? value) {
    selectedState = value;
    print(selectedState!.name);
    selectedCity = null;
    cities.clear();
    notifyListeners();
  }

  setCity(CityData? value) {
    selectedCity = value;
    print(selectedCity!.name);
    notifyListeners();
  }

  setDropdownData({
    required String country,
    required String state,
    required String city,
  }) async {
    await getCountries();
    selectedCountry = await findCountry(country);
    selectedState =
        await findState(name: state, id: selectedCountry!.id.toString());
    selectedCity =
        await findCities(name: city, id: selectedState!.id.toString());
  }

  findCountry<CountyData>(String name) {
    // print(name);
    return countries.firstWhere((element) =>
        element.name.toString().toLowerCase() == name.toLowerCase());
  }

  findState<StateData>({required String name, required String id}) async {
    await getStates(id: id);
    print("states: ${states.length}");
    return states.firstWhere((element) =>
        element.name.toString().toLowerCase() == name.toLowerCase());
  }

  findCities<CityData>({required String name, required String id}) async {
    // print(name);
    await getCities(id: id);
    print("cities: ${cities.length}");
    return cities.firstWhere((element) =>
        element.name.toString().toLowerCase() == name.toLowerCase());
  }

  List<CountyData> countries = [];
  List<StateData> states = [];
  List<CityData> cities = [];

  Future<void> getCountries() async {
    countries.clear();
    await _myRepo.countryList(api: AppUrl.getCountries).then((value) {
      if (value.status == false) {
        Utils.showTost(msg: value.message.toString());
      } else {
        countries = value.data;
      }
      setLoading(false);
    });
  }

  Future<void> getStates({required String id}) async {
    await _myRepo.StateList(api: AppUrl.getStates, countryId: id).then((value) {
      if (value.status == false) {
        Utils.showTost(msg: value.message.toString());
      } else {
        states = value.data;
      }
      setLoading(false);
    });
  }

  Future<void> getCities({required String id}) async {
    await _myRepo.CityList(api: AppUrl.getCities, StateId: id).then((value) {
      if (value.status == false) {
        Utils.showTost(msg: value.message.toString());
      } else {
        cities = value.data;
      }
      setLoading(false);
    });
  }
}

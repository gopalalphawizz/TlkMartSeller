import 'package:alpha_work/Model/cityModel.dart';
import 'package:alpha_work/Model/countryModel.dart';
import 'package:alpha_work/Model/stateModel.dart';
import 'package:alpha_work/Model/vendorProfileModel.dart';
import 'package:alpha_work/Router/router.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/ViewModel/addressViewModel.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/DropdownDeco.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditAddressDetailScreen extends StatefulWidget {
  final VendorData vendorData;

  EditAddressDetailScreen({super.key, required this.vendorData});

  @override
  State<EditAddressDetailScreen> createState() =>
      _EditAddressDetailScreenState();
}

class _EditAddressDetailScreenState extends State<EditAddressDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController zipCtrl = TextEditingController();
  final TextEditingController AddressCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  late ProfileViewModel profilePro;
  late AddressViewModel addressP;
  @override
  void initState() {
    addressCtrl.text = widget.vendorData.shop!.address.toString();
    cityCtrl.text = widget.vendorData.shop!.city.toString();
    stateCtrl.text = widget.vendorData.shop!.state.toString();
    zipCtrl.text = widget.vendorData.shop!.pincode.toString();
    countryCtrl.text = widget.vendorData.shop!.country.toString();
    print(countryCtrl.text);
    profilePro = Provider.of<ProfileViewModel>(context, listen: false);
    addressP = Provider.of<AddressViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Address Information"),
      body: FutureBuilder(
          future: addressP.setDropdownData(
              country: countryCtrl.text,
              state: stateCtrl.text,
              city: cityCtrl.text),
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? appLoader()
                : SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressCtrl,
                              textInputAction: TextInputAction.next,
                              decoration: (const InputDecoration())
                                  .applyDefaults(
                                      Theme.of(context).inputDecorationTheme)
                                  .copyWith(labelText: "Business Address*"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Business Address";
                                }
                                return null;
                              },
                            ),
                            const Divider(color: Colors.transparent),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: DropDownDeco(ctx: context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12),
                                child: Consumer<AddressViewModel>(
                                    builder: (context, val, _) {
                                  return DropdownButton<CountyData>(
                                    underline: Container(),
                                    isExpanded: true,
                                    dropdownColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? colors.darkBG
                                            : Colors.white,
                                    value: val.selectedCountry,
                                    onChanged: (value) {
                                      setState(() {
                                        val.setCountry(value!);

                                        val.getStates(id: value.id.toString());
                                      });
                                    },
                                    items: addressP.countries
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                e.name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    hint: Text(
                                        addressP.selectedState == null
                                            ? "Select country"
                                            : countryCtrl.text,
                                        style: TextStyle(
                                            color: colors.greyText,
                                            fontWeight: FontWeight.normal)),
                                  );
                                }),
                              ),
                            ),
                            const Divider(color: Colors.transparent),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: DropDownDeco(ctx: context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12),
                                child: Consumer<AddressViewModel>(
                                    builder: (context, val, _) {
                                  return DropdownButton<StateData>(
                                    underline: Container(),
                                    isExpanded: true,
                                    dropdownColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? colors.darkBG
                                            : Colors.white,
                                    value: addressP.selectedState,
                                    onChanged: (value) {
                                      setState(() {
                                        val.set_State(value);

                                        val.getCities(id: value!.id.toString());
                                      });
                                    },
                                    items: addressP.states
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                e.name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    hint: Text(
                                        addressP.selectedState == null
                                            ? "Select State"
                                            : stateCtrl.text,
                                        style: TextStyle(
                                            color: colors.greyText,
                                            fontWeight: FontWeight.normal)),
                                  );
                                }),
                              ),
                            ),
                            const Divider(color: Colors.transparent),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: DropDownDeco(ctx: context),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12),
                                child: Consumer<AddressViewModel>(
                                    builder: (context, val, _) {
                                  return DropdownButton<CityData>(
                                    underline: Container(),
                                    isExpanded: true,
                                    dropdownColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? colors.darkBG
                                            : Colors.white,
                                    value: val.selectedCity,
                                    onChanged: (value) {
                                      setState(() {
                                        val.setCity(value);
                                      });
                                    },
                                    items: addressP.cities
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                e.name.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    hint: Text(
                                        addressP.selectedState == null
                                            ? "Select city"
                                            : cityCtrl.text,
                                        style: TextStyle(
                                            color: colors.greyText,
                                            fontWeight: FontWeight.normal)),
                                  );
                                }),
                              ),
                            ),
                            const Divider(color: Colors.transparent),
                            TextFormField(
                              controller: zipCtrl,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'\d+'))
                              ],
                              decoration: (const InputDecoration())
                                  .applyDefaults(
                                      Theme.of(context).inputDecorationTheme)
                                  .copyWith(labelText: "Postal/ZIP Code*"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Postal/ZIP Code";
                                }
                                return null;
                              },
                            ),
                            const Divider(color: Colors.transparent),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      addressP.selectedCountry != null &&
                                      addressP.selectedState != null &&
                                      addressP.selectedCity != null) {
                                    print(addressCtrl.text);
                                    print(addressP.selectedCountry?.name);
                                    print(addressP.selectedState?.name);
                                    print(addressP.selectedCity?.name);
                                    print(zipCtrl.text);
                                    await profilePro
                                        .updateAddressDetail(
                                          address: addressCtrl.text.toString(),
                                          country: addressP.selectedCountry !=
                                                  null
                                              ? addressP.selectedCountry!.name
                                                  .toString()
                                              : countryCtrl.text.toString(),
                                          state: addressP.selectedState != null
                                              ? addressP.selectedState!.name
                                                  .toString()
                                              : stateCtrl.text.toString(),
                                          city: addressP.selectedCity != null
                                              ? addressP.selectedCity!.name
                                                  .toString()
                                              : cityCtrl.text.toString(),
                                          pincode: zipCtrl.text.toString(),
                                        )
                                        .then(
                                          (value) => Fluttertoast.showToast(
                                            msg: value['msg'],
                                            backgroundColor: colors.buttonColor,
                                            textColor: Colors.white,
                                            gravity: ToastGravity.BOTTOM,
                                          ),
                                        );
                                    await profilePro
                                        .getvendorProfileData()
                                        .then(
                                            (value) => Navigator.pop(context));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .9, 50)),
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}

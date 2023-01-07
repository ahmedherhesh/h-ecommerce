import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/checkout.dart';
import 'package:get/get.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key});

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  Map arguments = Get.arguments ?? {};
  dynamic countrySelected, regionSelected, citySelected;
  List countries = [], regions = [], cities = [];
  String payment = '';
  String addressDescription = '';

  getCountries() async {
    countries = await get('countries');
    setState(() => countries);
  }

  getRegions(region) async {
    regions = await get('regions/$region');
    setState(() => regions);
  }

  getCities(city) async {
    cities = await get('cities/$city');
    setState(() => cities);
  }

  @override
  void initState() {
    getCountries();
    if (arguments['countrySelected'] != null && arguments['regionSelected'] != null) {
      getRegions(arguments['countrySelected']);
      getCities(arguments['regionSelected']);
    }
    countrySelected = arguments.containsKey('countrySelected') ? arguments['countrySelected'] : null;
    regionSelected = arguments.containsKey('regionSelected') ? arguments['regionSelected'] : null;
    citySelected = arguments.containsKey('citySelected') ? arguments['citySelected'] : null;
    addressDescription = arguments.containsKey('addressDescription') ? arguments['addressDescription'] : '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: arguments['pageTitle'] ?? 'Add New Address'),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            //Countries
            CustomDropdown(
              labelText: 'Choose Your Countries',
              items: countries,
              onChanged: (value) {
                String val = value.toString();
                getRegions(val);
                setState(() {
                  countrySelected = val.isNotEmpty ? val : null;
                });
              },
              selectedItem: countrySelected,
            ),
            //Regions
            Visibility(
              visible: countrySelected != null,
              child: CustomDropdown(
                labelText: 'Choose Your Region',
                items: regions,
                onChanged: (value) {
                  String val = value.toString();
                  getCities(val);
                  setState(() {
                    regionSelected = val.isNotEmpty ? val : null;
                  });
                },
                selectedItem: regionSelected,
              ),
            ),
            //Cities
            Visibility(
              visible: regionSelected != null,
              child: CustomDropdown(
                labelText: 'Choose Your City',
                items: cities,
                onChanged: (value) {
                  String val = value.toString();
                  setState(() {
                    citySelected = val.isNotEmpty ? val : null;
                  });
                },
                selectedItem: citySelected,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [boxShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                cursorColor: primaryColor,
                initialValue: addressDescription,
                decoration: InputDecoration(
                  labelText: 'Write your address description',
                  labelStyle: labelStyle,
                  enabledBorder: enabledBorder,
                  border: border,
                  focusedBorder: focusedBorder,
                ),
                onChanged: ((value) => setState(() => addressDescription = value)),
              ),
            ),
            submitButton(
              title: arguments['btnTitle'] ?? 'Create',
              onPressed: () async {
                Map body = {
                  'country': countrySelected.toString(),
                  'region': regionSelected.toString(),
                  'city': citySelected.toString(),
                  'description': addressDescription.toString()
                };
                String action = arguments['action'] ?? 'create';
                if (action == 'update') body['id'] = arguments['id'].toString();
                var sendAddress = await post(
                  route: 'shipping-addresses/$action',
                  body: body,
                );
                switch (sendAddress.statusCode) {
                  case 200:
                    Get.back(result: jsonDecode(sendAddress.body)['id']);
                    break;
                  case 422:
                    awesomeDialog(context, sendAddress.body).show();
                    break;
                }
              },
              iconShow: false,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/checkout.dart';
import 'package:get/get.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key, this.countrySelected, this.regionSelected, this.citySelected, this.addressDescription});
  final countrySelected;
  final regionSelected;
  final citySelected;
  final addressDescription;
  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  var countrySelected = null, regionSelected = null, citySelected = null;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Add New Address'),
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
                  val.toString().isNotEmpty ? countrySelected = val : countrySelected = null;
                });
              },
              selectedItem: widget.countrySelected ?? countrySelected,
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
                    val.isNotEmpty ? regionSelected = val : regionSelected = null;
                  });
                },
                selectedItem: widget.regionSelected ?? regionSelected,
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
                    val.isNotEmpty ? citySelected = val : citySelected = '';
                  });
                },
                selectedItem: widget.citySelected ?? citySelected,
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
                initialValue: widget.addressDescription ?? addressDescription,
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
              title: 'Create',
              onPressed: () async {
                var createAddress = await post(
                  route: 'shipping-addresses/create',
                  body: {
                    'country': countrySelected.toString(),
                    'region': regionSelected.toString(),
                    'city': citySelected.toString(),
                    'description': addressDescription.toString()
                  },
                );
                switch (createAddress.statusCode) {
                  case 200:
                    Get.back(result: jsonDecode(createAddress.body)['id']);
                    break;
                  case 422:
                    awesomeDialog(context, createAddress.body).show();
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

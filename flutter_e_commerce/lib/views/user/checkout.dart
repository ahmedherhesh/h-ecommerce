import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/checkout_btn.dart';
import 'package:get/get.dart';

class Checkout extends StatefulWidget {
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var countrySelected = null, regionSelected = null, citySelected = null;
  List countries = [], regions = [], cities = [];
  String payment = '';
  String address = '';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Checkout', context: context),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
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
                    val.isNotEmpty ? regionSelected = val : regionSelected = null;
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
                    val.isNotEmpty ? citySelected = val : citySelected = '';
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
                decoration: InputDecoration(
                  labelText: 'Write your address description',
                  labelStyle: labelStyle,
                  enabledBorder: enabledBorder,
                  border: border,
                  focusedBorder: focusedBorder,
                ),
                onChanged: ((value) => setState(() => address = value)),
              ),
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15, left: 5),
                  child: Text(
                    'Choose Your Payment Method',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Payment(name: 'paypal', payment: payment, onTap: () => setState(() => payment = 'paypal')),
              ],
            ),

            CheckoutButton(
                title: 'Let\'s Do It ',
                onPressed: () => payment.isNotEmpty
                    ? Get.toNamed(
                        payment,
                        arguments: {
                          'country': countrySelected ?? '',
                          'region': regionSelected ?? '',
                          'city': citySelected ?? '',
                          'address': address,
                          'payment_method': payment,
                          'order_details': Get.arguments['order_details'],
                        },
                      )
                    : null)
          ],
        ),
      ),
    );
  }
}

class Payment extends StatelessWidget {
  Payment({Key? key, this.name, this.payment, this.onTap}) : super(key: key);
  final name;
  final payment;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [boxShadow],
      ),
      child: ListTile(
        leading: Image.asset('assets/images/paypal.png'),
        title: const Text('Continue With Paypal'),
        textColor: textColor,
        onTap: onTap,
        trailing: Icon(payment == name ? Icons.radio_button_checked : Icons.radio_button_off, color: primaryColor),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({Key? key, this.items, this.onChanged, this.labelText, this.selectedItem}) : super(key: key);
  final items;
  final onChanged;
  final labelText;
  final selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<String>(
        popupProps: PopupProps.modalBottomSheet(
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
            cursorColor: primaryColor,
            decoration: InputDecoration(
              enabledBorder: enabledBorder,
              border: border,
              focusedBorder: focusedBorder,
              fillColor: primaryColor,
              labelText: 'Search',
              labelStyle: labelStyle,
            ),
          ),
        ),
        items: <String>[...items],
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: labelStyle,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: enabledBorder,
            border: border,
            focusedBorder: focusedBorder,
            labelText: labelText,
            labelStyle: labelStyle,
          ),
        ),
        onChanged: (value) => onChanged(value),
        selectedItem: selectedItem,
        validator: (item) => item == null ? 'Required field' : '',
      ),
    );
  }
}

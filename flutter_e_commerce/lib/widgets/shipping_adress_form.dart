import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/checkout.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key});
  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
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
            submitButton(title: 'Add', onPressed: () {}, iconShow: false)
          ],
        ),
      ),
    );
  }
}

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
  String? payment;

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
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Color.fromARGB(255, 184, 181, 181), blurRadius: 6)],
            color: Colors.white,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              //Countrimahes
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
              textInput(icon: Icons.place_outlined, hintText: 'Write your address description'),
              Container(
                margin: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  'Choose Your Favourite Payment',
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              Payment(payment: payment, onTap: () => setState(() => payment = 'paypal')),
              CheckoutButton(onPressed: () => payment != null ? Get.toNamed('$payment') : null),
            ],
          ),
        ),
      ),
    );
  }
}

class Payment extends StatelessWidget {
  Payment({Key? key, this.payment, this.onTap}) : super(key: key);
  final payment;
  final onTap;
  Map icons = {'paypal': Icons.radio_button_checked};
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0xffdddddd),
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset('assets/images/paypal.png'),
        title: const Text('Continue With Paypal'),
        textColor: textColor,
        onTap: onTap,
        trailing: Icon(icons[payment] ?? Icons.radio_button_off, color: primaryColor),
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
    return DropdownSearch<String>(
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          cursorColor: primaryColor,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: primaryColor,
            labelText: 'Search',
            labelStyle: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
      items: <String>[...items],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: textColor,
          ),
        ),
      ),
      onChanged: (value) => onChanged(value),
      selectedItem: selectedItem,
      validator: (item) => item == null ? 'Required field' : '',
    );
  }
}

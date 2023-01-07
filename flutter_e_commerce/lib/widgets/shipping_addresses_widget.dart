import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_list_tile.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:get/get.dart';

class ShippingAddressesWidget extends StatefulWidget {
  const ShippingAddressesWidget({super.key, this.iconData, this.addBtnVisible, this.onChanged, this.page});
  final iconData;
  final addBtnVisible;
  final onChanged;
  final page;
  @override
  State<ShippingAddressesWidget> createState() => _ShippingAddressesWidgetState();
}

class _ShippingAddressesWidgetState extends State<ShippingAddressesWidget> {
  int? addressId;
  @override
  Widget build(context) {
    return FutureBuilder(
      future: get('shipping-addresses'),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(15),
            children: [
              //header
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Saved Addresses :',
                      style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    widget.addBtnVisible == true
                        ? IconButton(
                            onPressed: () async {
                              var result = await Get.toNamed('shipping-address-form');
                              if (result.runtimeType == int) {
                                setState(() => addressId = result);
                                widget.onChanged(addressId);
                              }
                            },
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: primaryColor,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              //generate saved addresses as list tiles
              ...List.generate(
                data.length,
                (i) => CustomListTile(
                  title: '${data[i]['country']}',
                  subtitle: '${data[i]['region']}, ${data[i]['city']}, ${data[i]['description']}',
                  onTap: () {
                    setState(() => addressId = data[i]['id']);
                    //export address id to the page used onChange function in shipping address widget
                    widget.onChanged(addressId);
                  },
                  trailing: IconButton(
                      // if addressId != data[i]['id'] then el will not selected else it will has a selected icon with primary color
                      icon: addressId != data[i]['id']
                          ? Icon(widget.iconData, color: textColor)
                          : Icon(
                              Icons.radio_button_on,
                              color: primaryColor,
                            ),
                      onPressed: widget.page == 'checkout'
                          ? () => setState(() => addressId = data[i]['id'])
                          : () async {
                              var result = await Get.toNamed(
                                'shipping-address-form',
                                arguments: {
                                  'id': data[i]['id'],
                                  'countrySelected': data[i]['country'],
                                  'regionSelected': data[i]['region'],
                                  'citySelected': data[i]['city'],
                                  'addressDescription': data[i]['description'],
                                  'btnTitle': 'Save',
                                  'pageTitle': 'Update Address',
                                  'action': 'update',
                                },
                              );
                              if (result.runtimeType == int) setState(() {});
                            }),
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        } else {
          return EmptyPage(page: 'shipping');
        }
      },
    );
  }
}

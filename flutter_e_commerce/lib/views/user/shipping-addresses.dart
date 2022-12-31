import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/shipping_addresses_widget.dart';
import 'package:get/get.dart';

class ShippingAddresses extends StatefulWidget {
  const ShippingAddresses({super.key});
  @override
  State<ShippingAddresses> createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Shipping Addresses'),
      body: const ShippingAddressesWidget(
        iconData: Icons.edit,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed('shipping-address-form');
          if (result.runtimeType == int) setState(() {});
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_list_tile.dart';
import 'package:get/get.dart';

class ShipingAddresses extends StatelessWidget {
  const ShipingAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Shipping Adresses'),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          CustomListTile(
            title: 'Title',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('shipping-address-form'),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

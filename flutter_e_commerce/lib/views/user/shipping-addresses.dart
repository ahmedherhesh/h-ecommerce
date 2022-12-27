import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_list_tile.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
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
      appBar: appBar(title: 'Shipping Adresses'),
      body: FutureBuilder(
        future: get('shipping-addresses'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(15),
              children: List.generate(
                data.length,
                (i) => CustomListTile(
                  title: '${data[i]['country']}',
                  subtitle: '${data[i]['region']}, ${data[i]['city']}',
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          } else {
            return EmptyPage(page: 'shipping');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed('shipping-address-form');
          if (result == true) setState(() {});
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:get/get.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'My Orders'),
      body: FutureBuilder(
        future: get('customer-orders'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          } else if (snapshot.hasData) {
            List data = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(8),
              children: List.generate(
                data.length,
                (i) => InkWell(
                  onTap: () => Get.toNamed('order-details', arguments: {'order_details': data[i]['order_details']}),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffdddddd),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order No. ${data[i]['payment_id']}',
                          style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: textColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

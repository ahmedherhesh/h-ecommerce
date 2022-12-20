import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});
  List orderDetails = Get.arguments['order_details'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Order Details'),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: List.generate(
          orderDetails.length,
          (i) => Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      orderDetails[i]['product_image'],
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderDetails[i]['product_title'],
                          style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${orderDetails[i]['price']} ${orderDetails[i]['currency']}',
                          style: TextStyle(color: textColor, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Qty : ${orderDetails[i]['qty']}',
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                    Text(
                      'Total: ${orderDetails[i]['total_price']} ${orderDetails[i]['currency']}',
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                    Text(
                      'Status: ${orderDetails[i]['status']}',
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

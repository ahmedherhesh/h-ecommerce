import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({Key? key, required this.page, this.message}) : super(key: key);
  String? page;
  final message;
  Map pagesIcon = {
    'favourites': Icons.favorite_outline,
    'cart': Icons.shopping_cart_outlined,
    'orders': Icons.shopping_bag_outlined,
    'search': Icons.search_outlined,
    'shipping': Icons.local_shipping_outlined,
    'no-internet': Icons.wifi_off_outlined,
  };
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            pagesIcon[page],
            color: primaryColor,
            size: 120,
          ),
          Text(
            message != null ? '$message' : 'Empty',
            style: const TextStyle(color: Colors.blueGrey, fontSize: 28, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

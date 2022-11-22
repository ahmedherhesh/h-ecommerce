import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';

class PayPal extends StatefulWidget {
  State<PayPal> createState() => _PayPalState();
}

class _PayPalState extends State<PayPal> {
  void initState() {
    super.initState();
  }

  final url = "https://www.google.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context: context, title: 'Checkout')
        // body: WebView(
        //   initialUrl: 'https://flutter.dev',
        // ),
        );
  }
}

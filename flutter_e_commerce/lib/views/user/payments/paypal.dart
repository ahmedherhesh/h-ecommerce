import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPal extends StatefulWidget {
  State<PayPal> createState() => _PayPalState();
}

class _PayPalState extends State<PayPal> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Checkout'),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://malik2.com/payment?plan_id=2&app_token=app_token',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) => setState(() => loading = false),
          ),
          loading ? Center(child: CircularProgressIndicator(color: primaryColor)) : const SizedBox()
        ],
      ),
    );
  }
}

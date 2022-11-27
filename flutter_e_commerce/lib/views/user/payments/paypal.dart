import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPal extends StatefulWidget {
  State<PayPal> createState() => _PayPalState();
}

class _PayPalState extends State<PayPal> {
  bool loading = true;
  String initialUrl = '${initData['apiUrl']}/payment';
  Color paypalColor = const Color(0XFF005ea6);
  var body = Get.arguments;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: paypalColor,
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) {
              setState(() => loading = false);
            },
            onWebViewCreated: (WebViewController wvController) {
              Map<String, String> headers = {
                'Authorization': initData['headers']['Authorization'] ?? '',
                'country': body['country'] ?? '',
                'region': body['region'] ?? '',
                'city': body['city'] ?? '',
                'address': body['address'] ?? '',
                'payment_method': body['payment_method'] ?? '',
                'order_details': body['order_details'] ?? '',
              };
              wvController.loadUrl(initialUrl, headers: headers);
            },
          ),
          loading ? Center(child: CircularProgressIndicator(color: paypalColor)) : const SizedBox()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPal extends StatefulWidget {
  State<PayPal> createState() => _PayPalState();
}

class _PayPalState extends State<PayPal> {
  bool loading = true;
  String initialUrl = 'https://malik2.com/payment?plan_id=2&app_token=app_token';
  Color paypalColor = const Color(0XFF005ea6);
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
              Map<String, String> headers = {'Authorization': 'Bearer token'};
              wvController.loadUrl(initialUrl, headers: headers);
            },
          ),
          loading ? Center(child: CircularProgressIndicator(color: paypalColor)) : const SizedBox()
        ],
      ),
    );
  }
}

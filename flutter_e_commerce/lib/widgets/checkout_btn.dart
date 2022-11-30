import 'package:flutter/material.dart';
import '../design_settings/values.dart';

class CheckoutButton extends StatelessWidget {
  CheckoutButton({this.title, this.onPressed});
  final onPressed;
  final title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 15, bottom: 30, left: 15),
      child: MaterialButton(
        padding: const EdgeInsets.all(10),
        onPressed: onPressed,
        textColor: Colors.white,
        color: primaryColor,
        child: Text(title ?? 'Checkout', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';

class AuthBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              primaryColor,
              Color.fromARGB(255, 19, 184, 175),
            ],
          ),
        ),
      ),
    );
  }
}

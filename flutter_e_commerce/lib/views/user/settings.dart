import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';

class Settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Functions.appBar(context: context),
      body: Center(child: Text('Settings')),
    );
  }
}

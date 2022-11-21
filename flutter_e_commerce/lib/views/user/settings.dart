import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/auth-board.dart';

class Settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: const Center(child: Text('Settings')),
    );
  }
}

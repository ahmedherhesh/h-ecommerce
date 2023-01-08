import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPass = '', newPass = '', confirmPass = '';
  Future changePassword() async {
    var response = await post(route: 'change-password', body: {
      'old_password': oldPass,
      'password': newPass,
      'confirm_password': confirmPass,
    });
    int statusCode = response.statusCode;
    var body = jsonDecode(response.body);
    if (statusCode == 422 || statusCode == 403) {
      awesomeDialog(context, body).show();
    } else {
      snackBar(title: response.body, message: '');
      Get.offAllNamed(
        'main',
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Change password'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              textInput(hintText: 'Old password', onChanged: (val) => setState(() => oldPass = val)),
              textInput(hintText: 'New password', onChanged: (val) => setState(() => newPass = val)),
              textInput(hintText: 'Repeat a password', onChanged: (val) => setState(() => confirmPass = val)),
              submitButton(title: 'Apply', iconShow: false, onPressed: () => changePassword()),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatelessWidget {
  Map user = jsonDecode(initData['user']), data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Edit Profile'),
      body: ListView(
        children: [
          SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textInput(
                  val: user['name'],
                  icon: Icons.person,
                  hintText: 'Full Name',
                  onChanged: (val) {
                    data['name'] = val ?? user['name'];
                  },
                ),
                textInput(
                  val: user['username'],
                  icon: Icons.person,
                  hintText: 'Username',
                  onChanged: (val) {
                    data['username'] = val ?? user['username'];
                  },
                ),
                textInput(
                  val: user['email'],
                  icon: Icons.email,
                  hintText: 'Email',
                  onChanged: (val) {
                    data['email'] = val ?? user['email'];
                  },
                ),
                textInput(
                  val: user['phone'],
                  icon: Icons.phone,
                  hintText: 'Phone',
                  onChanged: (val) {
                    data['phone'] = val ?? user['phone'];
                  },
                ),
                submitButton(
                  iconShow: false,
                  title: 'Save',
                  onPressed: () async {
                    if (data.isNotEmpty) {
                      //send new data to backend
                      var editProfile = await post(route: 'edit-profile', body: data);
                      //response
                      Map body = jsonDecode(editProfile.body);
                      //get saved data from cache
                      Map user = jsonDecode(prefs!.getString('user').toString());
                      //refactoring data
                      body.forEach((key, value) {
                        user[key] = value;
                      });
                      //set new data in cache
                      prefs!.setString('user', jsonEncode(user));
                      //update initData['user]
                      initData['user'] = prefs!.getString('user');
                    }
                    Get.back(result: 1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

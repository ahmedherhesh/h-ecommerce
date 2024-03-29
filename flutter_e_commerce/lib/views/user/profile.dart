import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/init.dart';
import 'dart:convert';
import 'package:flutter_e_commerce/widgets/custom_list_tile.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  logout() async {
    await get('logout');
    prefs!.remove('user');
    Get.offAllNamed('main', arguments: {'pageIndex': 0});
  }

  @override
  Widget build(BuildContext context) {
    Map user = jsonDecode(initData['user']);
    return Scaffold(
      appBar: appBar(context: context, title: 'Profile'),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Column(
              children: [
                //edit profile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: textColor,
                          maxRadius: 40,
                          child: Text(
                            '${user['name'][0].toUpperCase()}',
                            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ucfirst(user['name']),
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                            Text(
                              user['email'],
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        var result = await Get.toNamed('edit-profile');
                        if (result.runtimeType == int) setState(() {});
                      },
                      icon: Icon(
                        Icons.edit,
                        color: textColor,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                CustomListTile(
                  title: 'My Orders',
                  onTap: () => Get.toNamed('my-orders'),
                ),
                CustomListTile(title: 'My Reviews'),
                CustomListTile(
                  title: 'Change Password',
                  onTap: () => Get.toNamed('change-password'),
                ),
                CustomListTile(
                  title: 'Shipping Addresses',
                  onTap: () => Get.toNamed('shipping-addresses'),
                ),
                const SizedBox(height: 50),
                submitButton(
                  title: 'Logout',
                  onPressed: () {
                    logout();
                  },
                  iconShow: false,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  String catName = Get.arguments['category_name'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: catName),
      body: Center(
        child: Text(catName),
      ),
    );
  }
}

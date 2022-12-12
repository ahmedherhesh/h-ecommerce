import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: primaryColor));
  }
}

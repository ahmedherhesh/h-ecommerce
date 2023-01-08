import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:get/get.dart';

class CustomFutureBuilder extends StatelessWidget {
  CustomFutureBuilder({super.key, required this.future, required this.ifFill, required this.ifEmpty});
  Future future;
  Function ifFill;
  Widget ifEmpty;
  bool buildState = false;
  @override
  Widget build(context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && buildState == false) {
          return const Padding(padding: EdgeInsets.all(8), child: CustomLoading());
        } else if (snapshot.hasData && buildState == false) {
          buildState = true;
          return ifFill(snapshot.data);
        }
        return ifEmpty;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';

class Orders extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Center(
        child: Text('You Don\'t Have Any Orders Yet'),
      ),
    );
  }
}

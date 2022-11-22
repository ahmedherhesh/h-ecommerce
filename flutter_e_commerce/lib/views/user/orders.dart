import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: const Center(
        child: Text('You Don\'t Have Any Orders Yet'),
      ),
    );
  }
}

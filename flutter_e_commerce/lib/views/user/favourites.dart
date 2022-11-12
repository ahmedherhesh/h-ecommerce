import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';

class Favourites extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Functions.appBar(context: context),
      body: Center(
        child: Text('Favourites'),
      ),
    );
  }
}

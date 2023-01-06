import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';

class NoInternet extends StatefulWidget {
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: appBar(),
      body: EmptyPage(page: 'no-internet', message: 'No Internet Connection'),
    );
  }
}

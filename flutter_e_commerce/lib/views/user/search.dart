import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? query;
  List products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textInput(val: query, hintText: 'Search'),
        backgroundColor: Colors.white,
        elevation: .8,
        actions: [
          IconButton(
            onPressed: () {
              setState(() => query = '');
            },
            icon: Icon(
              Icons.close,
              color: textColor,
            ),
          )
        ],
      ),
      body: products.isNotEmpty ? ListView() : EmptyPage(page: 'search'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:flutter_e_commerce/widgets/one_product.dart';
import 'package:get/get.dart';
import 'package:masonry_grid/masonry_grid.dart';

class Category extends StatefulWidget {
  List favBtns = [];
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String catName = Get.arguments['category_name'];
  List products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: catName),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: get('products/categories/$catName'),
            builder: (context, AsyncSnapshot snapshot) {
              snapshot.connectionState == ConnectionState.done ? products = snapshot.data : '';
              if (products.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView(
                    children: [
                      MasonryGrid(
                        column: 2,
                        children: [
                          Text(
                            ucfirst(catName),
                            style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ...List.generate(
                            products.length,
                            (i) {
                              var item = products[i];
                              item['in_favourite'] ? widget.favBtns.add(item['id']) : '';
                              return SizedBox(
                                height: 210,
                                child: OneProduct(
                                  item: item,
                                  icon: widget.favBtns.contains(item['id']) ? Icons.favorite : Icons.favorite_outline,
                                  onPressed: () {
                                    setState(() {
                                      if (widget.favBtns.contains(item['id'])) {
                                        widget.favBtns.remove(item['id']);
                                      } else {
                                        widget.favBtns.add(item['id']);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: primaryColor));
              }
              return EmptyPage(page: 'products');
            },
          ),
        ),
      ),
    );
  }
}

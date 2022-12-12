import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:flutter_e_commerce/widgets/one_product.dart';
import 'package:masonry_grid/masonry_grid.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  List favBtns = [];
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String terms = '';
  List products = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textInput(controller: controller, hintText: 'Enter a search term', onChanged: (val) => setState(() => terms = val)),
        backgroundColor: Colors.white,
        elevation: .8,
        actions: [
          IconButton(
            onPressed: () {
              controller.clear();
              setState(() => terms = '');
            },
            icon: Icon(
              Icons.close,
              color: textColor,
            ),
          )
        ],
      ),
      body: terms.length > 2
          ? FutureBuilder(
              future: get('products?terms=$terms'),
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
                              ucfirst(terms),
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
                  return const CustomLoading();
                }
                return EmptyPage(page: 'search');
              },
            )
          : const SizedBox(),
    );
  }
}

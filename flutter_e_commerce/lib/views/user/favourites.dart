import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';
import 'package:get/get.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List favourites = [];
  productsInFavourites() async {
    Uri url = Uri.parse('${initData['apiUrl']}/favourites');
    var response = await http.get(url, headers: initData['headers']);
    List data = jsonDecode(response.body);
    setState(() {
      if (data.isNotEmpty && response.statusCode == 200) {
        favourites.addAll(data);
        favourites.remove('empty');
      } else {
        favourites.add('empty');
      }
    });
  }

  @override
  void initState() {
    productsInFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Functions.appBar(context: context),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        //inside loop
        child: favourites.isNotEmpty && !favourites.contains('empty')
            ? GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: .66),
                itemCount: favourites.length,
                itemBuilder: (context, i) {
                  var item = favourites[i];
                  return MaterialButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Get.toNamed(
                      'product',
                      arguments: {
                        'keyword': '${item['keyword']}',
                      },
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      margin:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xFFdddddd),
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Image.asset(
                            fit: BoxFit.cover,
                            'assets/images/sale.jpg',
                            height: 135,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    '${item['title']}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                // ignore: sized_box_for_whitespace
                                Container(
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${item['price']}',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          setState(() {
                                            addOrDelFavourite(
                                                productId: item['id'],
                                                productTitle: item['title']);
                                            favourites.removeAt(i);
                                            if (favourites.isEmpty)
                                              favourites.add('empty');
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.blueGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: !favourites.contains('empty')
                    ? CircularProgressIndicator(color: primaryColor)
                    : const Text('You Dont Have Any Favourites Yet!')),
      ),
    );
  }
}

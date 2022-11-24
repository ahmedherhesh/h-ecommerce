import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:get/get.dart';

class Favourites extends StatefulWidget {
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List favourites = [];
  bool widgetBuild = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        //inside loop
        child: FutureBuilder(
          future: get('favourites'),
          builder: (context, AsyncSnapshot snapshot) {
            if (widgetBuild == false && snapshot.connectionState == ConnectionState.done) {
              favourites = snapshot.data;
              widgetBuild = true;
            }
            if (favourites.isNotEmpty) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: .66),
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
                      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            addOrDelFavourite(productId: item['id'], productTitle: item['title']);
                                            favourites.removeAt(i);
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
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            }
            return EmptyPage(page: 'favourites');
          },
        ),
      ),
    );
  }
}

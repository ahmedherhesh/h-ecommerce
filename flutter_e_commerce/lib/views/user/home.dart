import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/components/widgets.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> key = new GlobalKey();
  int currentIndex = 0;
  int currentSlide = 0;
  List sliderImages = [];
  List categoryWithProducts = [];

  slider() async {
    Uri url = Uri.parse('${initData['apiUrl']}/slider');
    var response = await http.get(url);
    setState(() {
      if (response.body.isNotEmpty) {
        sliderImages.addAll(jsonDecode(response.body));
      }
    });
  }

  products() async {
    Uri url = Uri.parse('${initData['apiUrl']}/category-with-products');
    var response = await http.get(url);
    setState(() {
      if (response.body.isNotEmpty) {
        categoryWithProducts.addAll(jsonDecode(response.body));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Functions.checkAuth();
    slider();
    products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: Functions.appBar(context: context),
      body: ListView(
        children: [
          //Home Page Slider
          Column(
            children: [
              //Slider Images
              Container(
                clipBehavior: Clip.hardEdge,
                height: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFFdddddd),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ]),
                margin: const EdgeInsets.all(10),
                child: sliderImages.isNotEmpty
                    ? PageView(
                        onPageChanged: (index) => setState(() {
                          currentSlide = index;
                        }),
                        children: List.generate(
                          sliderImages.length,
                          (index) => Image.network(
                            fit: BoxFit.cover,
                            '${sliderImages[index]}',
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      ),
              ),
              //Slider Indicators
              SliderIndicators(
                sliderImagesCount: sliderImages.length,
                currentSlide: currentSlide,
              ),
            ],
          ),
          //Categories
          Functions.categories(),
          categoryWithProducts.isNotEmpty
              ? Column(
                  //outside loop
                  children: List.generate(categoryWithProducts.length, (index) {
                    var el = categoryWithProducts[index];
                    String category = el.keys.toList().first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // category
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 5, top: 10),
                          child: Text(
                            '${category[0].toUpperCase()}${category.substring(1)}',
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //category's products
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(left: 5),
                          //inside loop
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, childAspectRatio: 1.3),
                              itemCount: el[el.keys.first].toList().length,
                              itemBuilder: (context, childIndex) {
                                var item = el[category].toList()[childIndex];
                                return MaterialButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () =>
                                      Navigator.of(context).pushNamed('product',
                                          arguments: Product(
                                            title: '${item['title']}',
                                          )),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 5),
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
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\$${item['price']}',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.favorite_outline,
                                                        color: primaryColor,
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
                              }),
                        ),
                      ],
                    );
                  }),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
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
    Uri url = Uri.parse(apiUrl + '/slider');
    var response = await http.get(url);
    setState(() {
      if (response.body.isNotEmpty)
        sliderImages.addAll(jsonDecode(response.body));
    });
  }

  products() async {
    Uri url = Uri.parse(apiUrl + '/category-with-products');
    var response = await http.get(url);
    setState(() {
      if (response.body.isNotEmpty)
        categoryWithProducts.addAll(jsonDecode(response.body));
    });
  }

  @override
  void initState() {
    slider();
    products();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: Functions.appBar(context: context),
      body: ListView(
        children: [
          //Home Page Slider
          sliderImages.isNotEmpty
              ? Column(
                  children: [
                    //Slider Images
                    Container(
                        clipBehavior: Clip.hardEdge,
                        height: 160,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFdddddd),
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ]),
                        margin: EdgeInsets.all(10),
                        child: PageView(
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
                        )),
                    //Slider Indicators
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          sliderImages.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: currentSlide == index
                                  ? primaryColor
                                  : textColor,
                            ),
                            width: currentSlide == index ? 14 : 6,
                            height: 6,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Text(''),
          //Categories
          Functions.categories(),
          Column(
            children: List.generate(
                categoryWithProducts.length,
                (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 5, top: 10),
                          child: Text(
                            '${categoryWithProducts[index].keys.toList().first.toString()}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          margin: EdgeInsets.only(left: 5),
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 1.3),
                            itemCount: 20,
                            itemBuilder: (context, index) => MaterialButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => Navigator.of(context).pushNamed(
                                'product',
                                arguments: Product(title: 'Title test'),
                              ),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: const Text(
                                              'Title',
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$12.99',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.all(0),
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
                            ),
                          ),
                        ),
                      ],
                    )),
          )
        ],
      ),
    );
  }
}

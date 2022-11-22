import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/components/widgets.dart';
import 'package:get/get.dart';

class Product extends StatefulWidget {
  Product({Key? key, this.keyword}) : super(key: key);
  String? keyword;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int currentSlide = 0;
  Map productData = {};
  String? keyword;

  product() async {
    Map data = await get('products/${Get.arguments['keyword']}');
    setState(() => data.isNotEmpty ? productData = data : '');
  }

  addToCart(Map body) async {
    var data = await post(route: 'cart/create-or-update', body: body);
    return data.statusCode;
  }

  @override
  void initState() {
    product();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, right: 15, bottom: 5, left: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0xffdddddd),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            productData.isNotEmpty
                ? Text(
                    '${productData['currency'] == 'USD' ? '\$' : productData['currency']}${productData['price']}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CircularProgressIndicator(color: primaryColor),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color.fromARGB(255, 199, 208, 212),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    const Color.fromARGB(255, 14, 163, 156),
                    primaryColor,
                  ],
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: MaterialButton(
                minWidth: 100,
                padding: const EdgeInsets.all(8),
                onPressed: () async {
                  var status = await addToCart({'product_id': productData['id'].toString(), 'qty': '1'});
                  if (status == 200) Get.toNamed('main');
                },
                child: Row(
                  children: [
                    const Text(
                      'Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white.withOpacity(.7),
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: productData.isNotEmpty
          ? ListView(
              children: [
                //Product Page Slider
                Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: PageView(
                        onPageChanged: (index) => setState(() {
                          currentSlide = index;
                        }),
                        children: List.generate(
                          4,
                          (index) => Image.asset(
                            fit: BoxFit.cover,
                            'assets/images/sale.jpg',
                          ),
                        ),
                      ),
                    ),
                    //Slider Indicators
                    SliderIndicators(
                      sliderImagesCount: 4,
                      currentSlide: currentSlide,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 6, color: shadowColor),
                    ],
                  ),
                  //title, rating
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${productData['title']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              'Ahmed Herhesh',
                              style: TextStyle(fontSize: 14, color: textColor),
                            ),
                          ],
                        ),
                      ),
                      //rating
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '4.5',
                                style: TextStyle(color: textColor),
                              ),
                              Icon(
                                Icons.star_outline_outlined,
                                color: textColor,
                              ),
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(right: 10),
                            child: Text(
                              '(135 Reviews)',
                              style: TextStyle(color: textColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 6, color: shadowColor),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
                    child: Column(
                      children: [
                        TabBar(padding: const EdgeInsets.only(bottom: 15), labelColor: primaryColor, unselectedLabelColor: textColor, indicatorColor: primaryColor, tabs: const [
                          Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Reviews(135)',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        Container(
                          height: 200,
                          child: TabBarView(children: [
                            ListView(
                              children: [
                                Text(
                                  '* Details Details Details Details Details \n* Details Details Details\n* Details Details Details Details\n* Details Details Details Details Details Details\n* Details Details Details Details Details Details\n* Details Details Details\n* Details Details Details',
                                  style: TextStyle(fontSize: 16, color: textColor),
                                ),
                              ],
                            ),
                            ListView(
                              children: [
                                Text(
                                  'hello hello hello hello\nhello hello hello hello\nhello hello hello hello\nhello hello hello hello\nhello hello hello hello\nhello hello hello hello\nhello hello hello hello',
                                  style: TextStyle(fontSize: 16, color: textColor),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
    );
  }
}

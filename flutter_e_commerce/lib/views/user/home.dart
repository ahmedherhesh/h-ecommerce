import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:flutter_e_commerce/widgets/one_product.dart';
import 'package:flutter_e_commerce/widgets/widgets.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  int currentIndex = 0, currentSlide = 0;
  List sliderImages = [], categoryWithProducts = [], cats = [], favBtns = [];
  bool buildStatus = false;
  int loopCount = 0;
  slider() async {
    List data = await get('slider');
    setState(() {
      if (data.isNotEmpty) {
        sliderImages.addAll(data);
      }
    });
  }

  products() async {
    List data = await get('category-with-products');
    setState(() {
      if (data.isNotEmpty) {
        categoryWithProducts.addAll(data);
      }
    });
  }

  categories() async {
    List data = await get('categories');
    setState(() {
      if (data.isNotEmpty) {
        cats.addAll(data);
      }
    });
  }

  @override
  void initState() {
    slider();
    categories();
    checkAuth().then((data) => products());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: appBar(context: context),
      body: ListView(
        children: [
          //Home Page Slider
          Column(
            children: [
              //Slider Images
              Container(
                clipBehavior: Clip.hardEdge,
                height: 160,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
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
                        onPageChanged: (index) => setState(() => currentSlide = index),
                        children: List.generate(
                          sliderImages.length,
                          (index) => Image.network(
                            fit: BoxFit.cover,
                            '${sliderImages[index]}',
                          ),
                        ),
                      )
                    : const Padding(padding: EdgeInsets.all(15), child: CustomLoading()),
              ),
              //Slider Indicators
              SliderIndicators(
                sliderImagesCount: sliderImages.length,
                currentSlide: currentSlide,
              ),
            ],
          ),
          //Categories
          cats.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'Categories',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          cats.length,
                          (i) => InkWell(
                            onTap: () => Get.toNamed('category', arguments: {'category_name': cats[i]['name']}),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    primaryColor,
                                    const Color.fromARGB(255, 24, 160, 153),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  cats[i]['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const CustomLoading(),

          categoryWithProducts.isNotEmpty
              ? Column(
                  //outside loop
                  children: List.generate(categoryWithProducts.length, (index) {
                    var el = categoryWithProducts[index];
                    String category = el['category_name'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // category
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 5, top: 10),
                          child: Text(
                            ucfirst(category),
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //category's products
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(left: 5),
                          //inside loop
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: el['products'].toList().length,
                              itemBuilder: (context, childIndex) {
                                var item = el['products'].toList()[childIndex];
                                item['in_favourite'] && buildStatus == false ? favBtns.add(item['id']) : '';
                                // SchedulerBinding.instance.addPostFrameCallback((_) {});
                                return OneProduct(
                                  item: item,
                                  icon: favBtns.contains(item['id']) ? Icons.favorite : Icons.favorite_outline,
                                  onPressed: () {
                                    setState(() {
                                      buildStatus = true;
                                      if (favBtns.contains(item['id'])) {
                                        favBtns.remove(item['id']);
                                      } else {
                                        favBtns.add(item['id']);
                                      }
                                    });
                                  },
                                );
                              }),
                        ),
                      ],
                    );
                  }),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CustomLoading(),
                )
        ],
      ),
    );
  }
}

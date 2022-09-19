import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/search.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';
import 'package:flutter_e_commerce/views/components/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List buttons = [];
  setIcon(index, currentIndex, icon, icon_outlined) {
    return index == currentIndex ? icon : icon_outlined;
  }

  int currentIndex = 0;
  GlobalKey<ScaffoldState> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: Functions.appBar(context: context),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xffdddddd), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: setIcon(
                0,
                currentIndex,
                Icon(Icons.widgets, size: 27, color: primaryColor),
                Icon(Icons.widgets_outlined, size: 27, color: primaryColor),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: setIcon(
                1,
                currentIndex,
                Icon(Icons.shopping_bag, size: 27, color: primaryColor),
                Icon(Icons.shopping_bag_outlined,
                    size: 27, color: primaryColor),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              icon: setIcon(
                2,
                currentIndex,
                Icon(Icons.local_grocery_store, size: 27, color: primaryColor),
                Icon(Icons.local_grocery_store_outlined,
                    size: 27, color: primaryColor),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: setIcon(
                3,
                currentIndex,
                Icon(Icons.favorite, size: 27, color: primaryColor),
                Icon(Icons.favorite_outline, size: 27, color: primaryColor),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
                if (key.currentState!.hasEndDrawer) {
                  key.currentState!.openEndDrawer();
                }
              },
              icon: setIcon(
                4,
                currentIndex,
                Icon(Icons.person, size: 27, color: primaryColor),
                Icon(Icons.person_outline, size: 27, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
      body: ListView(
        children: [
          //Home Page Slider
          Column(
            children: [
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
                  children: [
                    Image.network(
                      fit: BoxFit.cover,
                      'https://img.freepik.com/free-vector/gradient-sale-background_23-2148945310.jpg?w=2000',
                    ),
                    Image.network(
                      fit: BoxFit.cover,
                      'https://img.freepik.com/free-vector/big-sale-background-with-offer_23-2148902856.jpg?w=2000',
                    ),
                    Image.network(
                      fit: BoxFit.cover,
                      'https://img.freepik.com/free-vector/gradient-sale-background_52683-62896.jpg?w=2000',
                    ),
                    Image.network(
                      fit: BoxFit.cover,
                      'https://img.freepik.com/free-vector/creative-sales-banner-with-abstract-details_52683-67038.jpg?w=2000',
                    ),
                  ],
                ),
              ),
              //Slider Indicators
              Container(
                width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 4,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 4,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 4,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
          //Categories
          Functions.categories(),
          Functions.categoryWithProducts(),
          Functions.categoryWithProducts(),
        ],
      ),
    );
  }
}

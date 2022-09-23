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
      bottomNavigationBar: Functions.bottomNavBar(
        setIcon: setIcon,
        setState: setState,
        currentIndex: currentIndex,
        context: context
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

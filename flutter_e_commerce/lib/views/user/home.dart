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
                Icon(Icons.widgets, size: 27),
                Icon(Icons.widgets_outlined, size: 27),
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
                Icon(Icons.shopping_bag, size: 27),
                Icon(Icons.shopping_bag_outlined, size: 27),
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
                Icon(Icons.local_grocery_store, size: 27),
                Icon(Icons.local_grocery_store_outlined, size: 27),
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
                Icon(Icons.favorite, size: 27),
                Icon(Icons.favorite_outline, size: 27),
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
                Icon(Icons.person, size: 27),
                Icon(Icons.person_outline, size: 27),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
      body: ListView(
        children: [
          Container(
            height: 200,
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
            child: PageView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'test',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Text(
                      'test',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Text(
                      'test',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(
                20,
                (index) => Container(
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'test',
                        style: TextStyle(color: Colors.black),
                      ),
                      const Text(
                        'test',
                        style: TextStyle(color: Colors.black),
                      ),
                      const Text(
                        'test',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

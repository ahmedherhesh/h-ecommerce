import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/search.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Commerce',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // leading: Image.asset('assets/images/h.gif'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                primaryColor,
                Color.fromARGB(255, 24, 160, 153),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.widgets_outlined, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_bag_outlined, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.local_grocery_store_outlined, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person_outline, size: 30),
            ),
          ],
        ),
      ),
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

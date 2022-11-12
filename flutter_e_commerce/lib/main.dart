import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/auth/register.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/auth-board.dart';
import 'package:flutter_e_commerce/views/user/cart.dart';
import 'package:flutter_e_commerce/views/user/favourites.dart';
import 'package:flutter_e_commerce/views/user/home.dart';
import 'package:flutter_e_commerce/views/user/orders.dart';
import 'package:flutter_e_commerce/views/user/product.dart';

void main() {
  runApp(const MyApp());
}

int pageIndex = 0;

List screens = [
  const Home(),
  Orders(),
  Cart(),
  Favourites(),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Main(),
      routes: {
        'login': (context) => const Login(),
        'register': (context) => const Register(),
        'main': (context) => const Main(),
        'product': (context) => Product(),
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    Functions.checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: pageIndex == 4,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        child: CurvedNavigationBar(
          height: 50,
          index: pageIndex,
          color: primaryColor,
          buttonBackgroundColor: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(Icons.home, size: 27),
            Icon(Icons.shopping_bag, size: 27),
            Icon(Icons.local_grocery_store, size: 27),
            Icon(Icons.favorite, size: 27),
            Icon(Icons.person, size: 27),
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
      body: screens[pageIndex],
    );
  }
}

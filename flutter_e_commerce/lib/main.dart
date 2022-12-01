import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/auth/register.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/views/user/cart.dart';
import 'package:flutter_e_commerce/views/user/checkout.dart';
import 'package:flutter_e_commerce/views/user/favourites.dart';
import 'package:flutter_e_commerce/views/user/home.dart';
import 'package:flutter_e_commerce/views/user/payments/paypal.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:flutter_e_commerce/views/user/profile.dart';
import 'package:flutter_e_commerce/views/user/search.dart';

import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

int pageIndex = 0;
List screens = [Home(), Search(), Cart(), Favourites(), Profile()], screensNeedAuth = [3, 4];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const Main(),
      routes: {
        'login': (context) => const Login(),
        'register': (context) => const Register(),
        'main': (context) => const Main(),
        'product': (context) => Product(),
        'checkout': (context) => Checkout(),
        'paypal': (context) => PayPal(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            Icon(Icons.search_outlined, size: 27),
            Icon(Icons.shopping_cart, size: 27),
            Icon(Icons.favorite, size: 27),
            Icon(Icons.person, size: 27),
          ],
          letIndexChange: (index) {
            if (screensNeedAuth.contains(index)) {
              checkAuth(redirect: true);
            }
            if (initData['Authorized']) {
              setState(() => pageIndex = index);
              return true;
            }
            return !screensNeedAuth.contains(index);
          },
          onTap: (index) {
            setState(() => pageIndex = index);
          },
        ),
      ),
      body: screens[pageIndex],
    );
  }
}

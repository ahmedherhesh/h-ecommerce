import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/auth/register.dart';
import 'package:flutter_e_commerce/views/user/auth-board.dart';
import 'package:flutter_e_commerce/views/user/cart.dart';
import 'package:flutter_e_commerce/views/user/favourites.dart';
import 'package:flutter_e_commerce/views/user/home.dart';
import 'package:flutter_e_commerce/views/user/orders.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:flutter_e_commerce/views/user/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        'login': (context) => Login(),
        'register': (context) => Register(),
        'main': (context) => Main(),
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

int pageIndex = 0;
List screens = [Home(), Orders(), Cart(), Favourites()];

class _MainState extends State<Main> {
  @override
  void initState() {
    checkAuth();
    initData['Authorized'] ? screens.add(Settings()) : screens.add(AuthBoard());
    super.initState();
  }

  checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      initData['user'] = prefs.getString('user');
    });

    Uri url = Uri.parse('${initData['apiUrl']}/user');
    var user = initData['user'] != null ? jsonDecode(initData['user']) : '';

    if (user.isNotEmpty) {
      setState(() {
        String token = 'Bearer ${user['token']}';
        initData['headers']['Authorization'] = token;
      });
      var response = await http.get(url, headers: initData['headers']);
      setState(() {
        response.statusCode == 200
            ? initData['Authorized'] = true
            : initData['Authorized'] = false;
      });

      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: pageIndex == 4,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        child: CurvedNavigationBar(
          height: 50,
          index: 0,
          color: primaryColor,
          buttonBackgroundColor: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          items: [
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

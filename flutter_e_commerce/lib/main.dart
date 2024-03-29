import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/user/user-controller/change-password.dart';
import 'package:flutter_e_commerce/views/user/user-controller/edit-profile.dart';
import 'package:flutter_e_commerce/views/user/user-controller/login.dart';
import 'package:flutter_e_commerce/views/user/user-controller/register.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/views/errors/no_internet.dart';
import 'package:flutter_e_commerce/views/user/cart.dart';
import 'package:flutter_e_commerce/views/user/category.dart';
import 'package:flutter_e_commerce/views/user/checkout.dart';
import 'package:flutter_e_commerce/views/user/favourites.dart';
import 'package:flutter_e_commerce/views/user/my-orders.dart';
import 'package:flutter_e_commerce/views/user/home.dart';
import 'package:flutter_e_commerce/views/user/order-details.dart';
import 'package:flutter_e_commerce/views/user/payments/paypal.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:flutter_e_commerce/views/user/profile.dart';
import 'package:flutter_e_commerce/views/user/search.dart';
import 'package:flutter_e_commerce/views/user/shipping-addresses.dart';
import 'package:flutter_e_commerce/views/user/shipping_address_form.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
  prefs = await SharedPreferences.getInstance();
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
      home: Main(),
      routes: {
        'login': (context) => Login(),
        'register': (context) => Register(),
        'change-password': (context) => ChangePassword(),
        'edit-profile': (context) => EditProfile(),
        'my-orders': (context) => MyOrders(),
        'order-details': (context) => OrderDetails(),
        'shipping-addresses': (context) => ShippingAddresses(),
        'shipping-address-form': (context) => ShippingAddressForm(),
        'main': (context) => Main(),
        'product': (context) => Product(),
        'category': (context) => Category(),
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
  dynamic connectivity;
  @override
  void initState() {
    connectivity = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      internetStatus = await InternetConnectionChecker().hasConnection;
      setState(() => internetStatus);
    });
    pageIndex = Get.arguments != null ? Get.arguments['pageIndex'] : 0;
    super.initState();
  }

  @override
  void dispose() {
    connectivity.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white, size: 27),
        ),
        child: CurvedNavigationBar(
          height: 50,
          index: pageIndex,
          color: primaryColor,
          buttonBackgroundColor: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(Icons.home),
            Icon(Icons.search_outlined),
            Icon(Icons.shopping_cart),
            Icon(Icons.favorite),
            Icon(Icons.person),
          ],
          letIndexChange: (index) {
            if (screensNeedAuth.contains(index)) {
              checkAuth(redirect: true);
            }
            if (initData['Authorized'] || internetStatus == false) {
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
      body: internetStatus == false ? NoInternet() : screens[pageIndex],
    );
  }
}

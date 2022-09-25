import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';

class Product extends StatefulWidget {
  Product({Key? key, this.title}) : super(key: key);
  String? title;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        appBar: Functions.appBar(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 8, right: 15, bottom: 5, left: 15),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [
            //     primaryColor,
            //     Color.fromARGB(255, 24, 160, 153),
            //   ],
            // ),
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
              Text(
                '\$19.99',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 199, 208, 212),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Color.fromARGB(255, 14, 163, 156),
                      primaryColor,
                    ],
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.all(8),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
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
        body: ListView(
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
          ],
        ));
  }
}

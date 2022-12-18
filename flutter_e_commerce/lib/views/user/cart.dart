import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:get/get.dart';

import '../../widgets/checkout_btn.dart';

class Cart extends StatefulWidget {
  List cartData = [];
  List orderDetails = [];
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  num price = 0;
  num shipping = 5;
  String? currency;
  int loopCount = 0;
  bool buildStatus = false;
// Stream getS() => Stream.periodic(Duration(milliseconds: 200)).asyncMap((event) => get('cart'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: FutureBuilder(
        future: get('cart'),
        builder: (context, AsyncSnapshot snapshot) {
          widget.cartData = snapshot.data ?? [];
          if (widget.cartData.isNotEmpty) {
            buildStatus = true;
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Color.fromARGB(255, 184, 181, 181), blurRadius: 6)],
                color: Colors.white,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10),
                  //cart products
                  ...List.generate(
                    widget.cartData.length,
                    (i) {
                      Map productData = widget.cartData[i]['product'];
                      currency = productData['currency'] == 'USD' ? '\$' : productData['currency'] + ' ';
                      if (loopCount < widget.cartData.length) {
                        price += productData['price'];
                        loopCount++;
                      }
                      return Container(
                        margin: const EdgeInsets.only(left: 15, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Cart Image
                                Image.network(
                                  productData['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                //Cart Title, Price
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productData['title'],
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$currency${productData['price']}',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //cart increment, decrement, remove
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //remove btn
                                SizedBox(
                                  height: 30,
                                  child: IconButton(
                                    onPressed: () async {
                                      var data = await get('cart/delete/${widget.cartData[i]['id']}');
                                      setState(() => widget.cartData.removeAt(i));
                                      snackBar(title: data, message: '');
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      size: 18,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    //decrement btn
                                    IconButton(
                                      onPressed: () => mounted && widget.cartData[i]['qty'] != 1
                                          ? setState(() {
                                              widget.cartData[i]['qty'] -= 1;
                                              price -= productData['price'];
                                            })
                                          : '',
                                      icon: Icon(
                                        color: primaryColor,
                                        Icons.remove_circle,
                                        size: 28,
                                      ),
                                    ),
                                    //qty
                                    Text('${widget.cartData[i]['qty']}'),
                                    //increment btn
                                    IconButton(
                                      onPressed: () => mounted && widget.cartData[i]['qty'] < productData['stock']
                                          ? setState(() {
                                              widget.cartData[i]['qty'] += 1;
                                              price += productData['price'];
                                            })
                                          : '',
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: primaryColor,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const PromoCode(),
                  CartPrice(currency: currency, price: price, shipping: shipping),
                  CheckoutButton(onPressed: () {
                    widget.orderDetails = [];
                    for (var item in widget.cartData) {
                      widget.orderDetails.add({'qty': item['qty'], 'product_id': item['product']['id']});
                    }
                    Get.toNamed(
                      'checkout',
                      arguments: {'order_details': jsonEncode(widget.orderDetails)},
                    );
                  }),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: primaryColor));
          }
          return EmptyPage(page: 'cart');
        },
      ),
    );
  }
}

class CartPrice extends StatelessWidget {
  const CartPrice({
    Key? key,
    required this.currency,
    required this.price,
    required this.shipping,
  }) : super(key: key);

  final String? currency;
  final num price;
  final num shipping;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$currency$price',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: primaryColor, width: 1),
                bottom: BorderSide(color: primaryColor, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$currency$shipping',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$currency${price + shipping}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromoCode extends StatelessWidget {
  const PromoCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, right: 15, bottom: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: shadowColor,
          ),
        ],
        color: Colors.white,
      ),
      child: Form(
        child: Stack(
          children: [
            TextFormField(
              autofocus: false,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Promo Code',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0), borderSide: BorderSide.none),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 199, 208, 212),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      const Color.fromARGB(255, 14, 163, 156),
                      primaryColor,
                    ],
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: MaterialButton(
                  minWidth: 100,
                  padding: const EdgeInsets.all(8),
                  onPressed: () {},
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List cartData = [];
  num price = 0;
  num shipping = 5;
  String? currency;
  int loopCount = 0;
  cart() async {
    var cart = await get('cart');
    if (mounted) setState(() => cartData = cart);
  }

  @override
  void initState() {
    cart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: cartData.isNotEmpty
          ? ListView(
              children: [
                const SizedBox(height: 10),
                //cart products
                ...List.generate(
                  cartData.length,
                  (i) {
                    Map productData = cartData[i]['product'];
                    currency = productData['currency'] == 'USD' ? '\$' : productData['currency'] + ' ';
                    if (loopCount < cartData.length) {
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
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: shadowColor,
                                  )
                                ]),
                                child: Image.network(
                                  productData['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
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
                                  onPressed: () {},
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
                                    onPressed: () => mounted && cartData[i]['qty'] != 1 ? setState(() => cartData[i]['qty'] -= 1) : '',
                                    icon: Icon(
                                      color: primaryColor,
                                      Icons.remove_circle,
                                      size: 28,
                                    ),
                                  ),
                                  //qty
                                  Text('${cartData[i]['qty']}'),
                                  //increment btn
                                  IconButton(
                                    onPressed: () => mounted && cartData[i]['qty'] < productData['stock'] ? setState(() => cartData[i]['qty'] += 1) : '',
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
                const CheckoutButton(),
              ],
            )
          : const EmptyPage(),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 15, bottom: 30, left: 15),
      child: MaterialButton(
        padding: const EdgeInsets.all(10),
        onPressed: () => Get.toNamed('checkout'),
        textColor: Colors.white,
        color: primaryColor,
        child: const Text('Checkout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
  const PromoCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
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
      )),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            color: primaryColor,
            size: 120,
          ),
          const Text(
            'Empty',
            style: TextStyle(color: Colors.blueGrey, fontSize: 28, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

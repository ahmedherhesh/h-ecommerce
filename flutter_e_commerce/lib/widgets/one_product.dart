import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:get/get.dart';

class OneProduct extends StatefulWidget {
  OneProduct({this.item, this.favBtns, this.onPressed, this.icon});
  final item;
  final favBtns;
  final onPressed;
  final icon;
  @override
  State<OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        'product',
        arguments: {
          'keyword': '${widget.item['keyword']}',
        },
      ),
      child: Container(
        width: 140,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Color(0xFFdddddd),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ]),
        child: Column(
          children: [
            Image.network(
              fit: BoxFit.cover,
              '${widget.item['image']}',
              height: 135,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${widget.item['title']}',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.item['price']}',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            addOrDelFavourite(productId: widget.item['id'], productTitle: widget.item['title']);
                              widget.onPressed();
                          },
                          icon: Icon(
                            widget.icon ,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// widget.favBtns != null && widget.favBtns.contains(widget.item['id'])  ? Icons.favorite : Icons.favorite_outline
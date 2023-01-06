import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/custom_loading.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            CachedNetworkImage(
              imageUrl: widget.item['image'],
              imageBuilder: (context, imageProvider) => Container(
                height: 135,
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomLoading(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.item['title']}',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            addOrDelFavourite(productId: widget.item['id'], productTitle: widget.item['title']);
                            widget.onPressed();
                          },
                          icon: Icon(
                            widget.icon,
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
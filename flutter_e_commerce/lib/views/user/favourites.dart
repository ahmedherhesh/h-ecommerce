import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/helpers/functions.dart';
import 'package:flutter_e_commerce/widgets/empty_page.dart';
import 'package:flutter_e_commerce/widgets/one_product.dart';
import 'package:masonry_grid/masonry_grid.dart';

class Favourites extends StatefulWidget {
  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List favourites = [];
  bool widgetBuild = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        child: FutureBuilder(
          future: get('favourites'),
          builder: (context, AsyncSnapshot snapshot) {
            if (widgetBuild == false && snapshot.connectionState == ConnectionState.done) {
              favourites = snapshot.data;
              widgetBuild = true;
            }
            if (favourites.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    MasonryGrid(
                      column: 2,
                      children: [
                        Text(
                          'Favourites',
                          style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ...List.generate(
                          favourites.length,
                          (i) {
                            var item = favourites[i];
                            return SizedBox(
                              height: 210,
                              child: OneProduct(
                                item: item,
                                onPressed: () => setState(() => favourites.removeAt(i)),
                                icon: Icons.delete,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            }
            return EmptyPage(page: 'favourites');
          },
        ),
      ),
    );
  }
}

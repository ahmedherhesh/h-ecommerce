import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/main.dart';
import 'package:flutter_e_commerce/views/components/search.dart';
import 'package:flutter_e_commerce/views/user/cart.dart';
import 'package:flutter_e_commerce/views/user/favourites.dart';
import 'package:flutter_e_commerce/views/user/home.dart';
import 'package:flutter_e_commerce/views/user/orders.dart';
import 'package:flutter_e_commerce/views/user/product.dart';
import 'package:flutter_e_commerce/views/user/settings.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Functions {
  static checkAuth() async {
    SharedPreferences sharedRef = await SharedPreferences.getInstance();
    if (sharedRef.getString('token') != null)
      return sharedRef.getString('token');
  }

  static appBar({context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'E-Commerce',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: Search());
          },
          icon: Icon(Icons.search),
        ),
      ],
      excludeHeaderSemantics: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              primaryColor,
              Color.fromARGB(255, 24, 160, 153),
            ],
          ),
        ),
      ),
    );
  }

  static textInput({val = '', hintText = '', icon = '', obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffdddddd),
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.blueGrey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: Colors.blueGrey,
      ),
    );
  }

  static oAuth({oAuth, oAuthClass, onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0xffdddddd),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/${oAuth.toLowerCase()}.png'),
        ),
        title: Text('Continue With $oAuth'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  static submitButton({text, onPressed}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            primaryColor,
            Color.fromARGB(255, 19, 184, 175),
          ],
        ),
      ),
      child: MaterialButton(
        minWidth: 200,
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$text',
              style: TextStyle(
                color: Color(0xffefefef),
                fontSize: 25,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.login,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  static authPageHeader({title, subtitle}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            primaryColor,
            Color.fromARGB(255, 24, 160, 153),
          ],
        ),
      ),
      width: double.infinity,
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '$subtitle',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Opacity(
              opacity: .3,
              child: Icon(
                Icons.waving_hand,
                color: Colors.white,
                size: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static categories() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Categories',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 5,
          ),
          children: List.generate(
            20,
            (index) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    primaryColor,
                    Color.fromARGB(255, 24, 160, 153),
                  ],
                ),
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(
                  Icons.laptop_chromebook,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

}
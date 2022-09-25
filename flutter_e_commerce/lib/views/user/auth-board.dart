import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';

class AuthBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              primaryColor,
              Color.fromARGB(255, 24, 160, 153),
              Color.fromARGB(255, 8, 92, 117),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: .3,
              child: Icon(
                Icons.waving_hand,
                size: 150,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Material(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: MaterialButton(
                    onPressed: () => Navigator.of(context).pushNamed('login'),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    color: Color.fromARGB(255, 5, 163, 163),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 30,
                      right: 30,
                    ),
                    minWidth: 300,
                    elevation: 10,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  clipBehavior: Clip.hardEdge,
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('register'),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    color: Color.fromARGB(255, 3, 179, 179),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 30,
                      right: 30,
                    ),
                    minWidth: 300,
                    elevation: 10,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

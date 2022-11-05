import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:flutter_e_commerce/views/components/functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? userGObj;
  googleLogin() {
    googleSignIn.signIn().then((data) {
      print(data);
    }).catchError((e) {
      print(e);
    });
  }

  Map data = {};

  // register(context) async {
  //   Uri uri = Uri.parse('${initData['apiUrl']}/register');
  //   var response = await http.post(uri, body: data);
  //   int statusCode = response.statusCode;
  //   var body = jsonDecode(response.body);

  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     initData['user'] = prefs.getString('user');
  //   });

  //   if (statusCode == 422) {
  //     AwesomeDialog(
  //       context: context,
  //       dialogType: DialogType.ERROR,
  //       animType: AnimType.SCALE,
  //       title: 'Validation Error',
  //       headerAnimationLoop: false,
  //       titleTextStyle: TextStyle(
  //         color: Colors.red,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 25,
  //       ),
  //       body: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: List.generate(
  //           body.length,
  //           (index) => Text(
  //             '${body[index]}',
  //             style: TextStyle(
  //               // fontWeight: FontWeight.bold,
  //               fontSize: 18,
  //             ),
  //           ),
  //         ),
  //       ),
  //       btnCancelOnPress: () {},
  //       btnOkOnPress: () {},
  //     ).show();
  //   } else if (statusCode == 200) {
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setString('user', jsonEncode(body));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Container(
          alignment: Alignment.topRight,
          child: MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).pushNamed('login');
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Color(0xffefefef),
                fontSize: 20,
              ),
            ),
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Functions.authPageHeader(
            title: 'Register',
            subtitle: 'Welcome To Ecommerce',
          ),
          Container(
            margin: EdgeInsets.only(top: 130),
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            //Login Form
            child: Form(
              child: ListView(
                children: [
                  //Email Field
                  Functions.textInput(
                    icon: Icons.person,
                    hintText: 'Full Name',
                    onChanged: (val) {
                      data['name'] = val;
                    },
                  ),
                  Functions.textInput(
                    icon: Icons.person,
                    hintText: 'Username',
                    onChanged: (val) {
                      data['username'] = val;
                    },
                  ),
                  Functions.textInput(
                    icon: Icons.email,
                    hintText: 'Email',
                    onChanged: (val) {
                      data['email'] = val;
                    },
                  ),
                  Functions.textInput(
                    icon: Icons.phone,
                    hintText: 'Phone',
                    onChanged: (val) {
                      data['phone'] = val;
                    },
                  ),
                  SizedBox(height: 10),
                  //Password Field
                  Functions.textInput(
                    icon: Icons.lock,
                    hintText: 'Password',
                    onChanged: (val) {
                      data['password'] = val;
                    },
                    obscure: true,
                  ),
                  Functions.textInput(
                    icon: Icons.lock,
                    hintText: 'Repeat Password',
                    obscure: true,
                    onChanged: (val) {
                      data['repeatPassword'] = val;
                    },
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        // Login Button
                        Functions.submitButton(
                          text: 'Register',
                          onPressed: () {
                            Functions.auth(
                              context: context,
                              data: data,
                              route: 'register',
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        //Continue with google button
                        Functions.oAuth(
                          oAuth: 'Google',
                          oAuthClass: googleSignIn,
                          onTap: googleLogin,
                        ),
                        //Continue with facebook button
                        Functions.oAuth(oAuth: 'Facebook'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

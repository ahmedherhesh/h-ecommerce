import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/auth/login.dart';
import 'package:flutter_e_commerce/views/components/widgets.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      body: ListView(children: [
        Stack(alignment: Alignment.topLeft, children: [
          Container(
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
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Register',
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
                    'Welcome To Ecommerce',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Email Field
                  Widgets.textInput(
                    icon: Icons.person,
                    hintText: 'Full Name',
                  ),
                  Widgets.textInput(
                    icon: Icons.person,
                    hintText: 'Username',
                  ),
                  Widgets.textInput(
                    icon: Icons.email,
                    hintText: 'Email',
                  ),
                  Widgets.textInput(
                    icon: Icons.phone,
                    hintText: 'Phone',
                  ),
                  SizedBox(height: 10),
                  //Password Field
                  Widgets.textInput(
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscure: true,
                  ),
                  Widgets.textInput(
                    icon: Icons.lock,
                    hintText: 'Repeat Password',
                    obscure: true,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        // Login Button
                        Widgets.submitButton(text: 'Register'),
                        SizedBox(height: 30),
                        //Continue with google button
                        Widgets.oAuth('Google'),
                        //Continue with facebook button
                        Widgets.oAuth('Facebook'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

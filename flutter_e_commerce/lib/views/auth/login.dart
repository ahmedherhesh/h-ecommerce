import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/auth/register.dart';
import 'package:flutter_e_commerce/views/components/widgets.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              Navigator.of(context).pushNamed('register');
            },
            child: Text(
              'Register',
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
                    'Login',
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
                    'Welcome Back',
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
                    hintText: 'Email, Phone Number',
                  ),
                  SizedBox(height: 10),
                  //Password Field
                  Widgets.textInput(
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscure: true,
                  ),
                  Container(
                    child: Column(
                      children: [
                        //Forget Password
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff555555),
                            ),
                          ),
                        ),
                        // Login Button
                        Widgets.submitButton(text: 'Login'),
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

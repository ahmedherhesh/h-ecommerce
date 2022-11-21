import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/views/helpers/functions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      body: Stack(alignment: Alignment.topLeft, children: [
        authPageHeader(
          title: 'Login',
          subtitle: 'Welcome Back',
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 130),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
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
                      textInput(
                        icon: Icons.person,
                        hintText: 'Email, Phone Number',
                        onChanged: (val) {
                          setState(() {
                            data['email'] = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      //Password Field
                      textInput(
                        icon: Icons.lock,
                        hintText: 'Password',
                        onChanged: (val) {
                          setState(() {
                            data['password'] = val;
                          });
                        },
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
                            submitButton(
                              text: 'Login',
                              onPressed: () async {
                                auth(
                                  context: context,
                                  data: data,
                                  route: 'login',
                                );
                                // Navigator.of(context)
                                //     .pushReplacementNamed('main');
                              },
                            ),
                            SizedBox(height: 30),
                            //Continue with google button
                            oAuth(
                              oAuth: 'Google',
                              oAuthClass: googleSignIn,
                              onTap: googleLogin,
                            ),
                            //Continue with facebook button
                            oAuth(oAuth: 'Facebook'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

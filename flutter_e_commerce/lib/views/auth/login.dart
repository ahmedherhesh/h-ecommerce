import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';

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
          child: Text(
            'Register',
            style: TextStyle(
              color: Color(0xffefefef),
              fontSize: 20,
            ),
          ),
        ),
        leading: Icon(Icons.arrow_back),
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffdddddd),
                        ),
                      ),
                    ),
                    //Email Field
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email , Phone Number',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blueGrey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Password Field
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffdddddd),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueGrey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.blueGrey,
                    ),
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
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 25, right: 25),
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
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Login',
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
                        ),
                        //Continue with google button
                        Container(
                          margin: EdgeInsets.only(top: 40, bottom: 10),
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
                            onTap: () {},
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/google.png'),
                            ),
                            title: Text('Continue With Google'),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ),
                        //Continue with facebook button
                        Container(
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
                            onTap: () {},
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/facebook.png'),
                            ),
                            title: Text('Continue With Facebook'),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ),
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

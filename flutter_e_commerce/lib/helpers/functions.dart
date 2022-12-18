import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';
import 'package:flutter_e_commerce/init.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future checkAuth({redirect = false}) async {
  final prefs = await SharedPreferences.getInstance();
  initData['user'] = prefs.getString('user');
  Uri url = Uri.parse('${initData['apiUrl']}/user');
  var user = initData['user'] != null ? jsonDecode(initData['user']) : '';

  if (user.isNotEmpty) {
    String token = 'Bearer ${user['token']}';
    initData['headers']['Authorization'] = token;
  }
  var response = await http.get(url, headers: initData['headers']);
  if (response.statusCode == 200) {
    initData['Authorized'] = true;
  } else {
    initData['Authorized'] = false;
    if (redirect) Get.toNamed('login');
  }
  return 200;
}

auth({context, data, route}) async {
  Uri uri = Uri.parse('${initData['apiUrl']}/$route');
  var response = await http.post(uri, body: data);
  int statusCode = response.statusCode;
  var body = jsonDecode(response.body);

  if (statusCode == 422 || statusCode == 403) {
    awesomeDialog(context, body).show();
  } else if (statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(body));
    initData['user'] = prefs.getString('user');
    Get.offAllNamed('main');
  }
}

AwesomeDialog awesomeDialog(context, body) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.SCALE,
    title: 'Validation Error',
    headerAnimationLoop: false,
    titleTextStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        body.values.length,
        (index) => Text(
          '${body.values.toList()[index][0]}',
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    ),
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  );
}

appBar({context, title = ''}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(title == '' ? 'SHOP' : title, style: const TextStyle(fontWeight: FontWeight.bold)),
    excludeHeaderSemantics: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            primaryColor,
            const Color.fromARGB(255, 24, 160, 153),
          ],
        ),
      ),
    ),
  );
}

textInput({val = '', TextEditingController? controller, hintText = '', labelText = '', IconData? icon, obscure = false, onChanged, BorderSide? customBorder}) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Color(0xffdddddd),
        ),
      ),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: TextStyle(color: textColor, fontSize: 18),
        prefixIcon: icon != null ? Icon(icon, color: Colors.blueGrey) : null,
        border: OutlineInputBorder(
          borderSide: customBorder ?? BorderSide.none,
        ),
      ),
      cursorColor: Colors.blueGrey,
      onChanged: onChanged,
    ),
  );
}

oAuth({oAuth, oAuthClass, onTap}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          blurRadius: 4,
          color: Color(0xffdddddd),
        ),
      ],
    ),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/${oAuth.toLowerCase()}.png'),
      ),
      title: Text('Continue With $oAuth'),
      trailing: const Icon(Icons.arrow_right),
    ),
  );
}

submitButton({String? title, onPressed, iconShow = true}) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          primaryColor,
          const Color.fromARGB(255, 19, 184, 175),
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
            '$title',
            style: const TextStyle(
              color: Color(0xffefefef),
              fontSize: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          iconShow
              ? const Icon(
                  Icons.login,
                  color: Colors.white,
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}

authPageHeader({title, subtitle}) {
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

//http get
get(String route) async {
  Uri url = Uri.parse('${initData['apiUrl']}/$route');
  var response = await http.get(url, headers: initData['headers']);
  return response.statusCode == 200 ? jsonDecode(response.body) : [];
}

//http post
post({String? route, Map? body}) async {
  Uri url = Uri.parse('${initData['apiUrl']}/$route');
  return await http.post(url, body: body, headers: initData['headers']);
}

void addOrDelFavourite({productId, productTitle}) async {
  var response = await post(route: 'favourites/create-or-delete', body: {'product_id': '$productId'});
  snackBar(title: productTitle, message: response.body);
}

void snackBar({title, message}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    backgroundGradient: LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        primaryColor,
        const Color.fromARGB(255, 24, 160, 153),
      ],
    ),
    duration: const Duration(seconds: 1),
    icon: const Icon(
      Icons.favorite_outline,
      color: Colors.white,
    ),
  );
}

String ucfirst(String word) {
  return word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '';
}

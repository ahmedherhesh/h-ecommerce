import 'package:shared_preferences/shared_preferences.dart';

Map initData = {
  'apiUrl': 'http://192.168.1.180/h-ecommerce/laravel-e-commerce/public/api/v1',
  'user': '',
  'headers': {'Authorization': ''},
  'Authorized': false
};
SharedPreferences? prefs;
bool internetStatus = true;

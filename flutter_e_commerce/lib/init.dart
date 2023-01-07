import 'package:shared_preferences/shared_preferences.dart';

Map initData = {
  'apiUrl': 'https://herhesh.tech/h-ecommerce/laravel-e-commerce/public/api/v1',
  'user': '',
  'headers': {'Authorization': ''},
  'Authorized': false
};
SharedPreferences? prefs;
bool internetStatus = true;

import 'package:appetize/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FrontPage.dart';
import 'globals.dart' as globals;

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('id') == null) {
    await prefs.setString('id', 'test_id_0120301230');
  }

  setRestaurantColors(globals.restaurants);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(FrontPage(globals.restaurants));
}

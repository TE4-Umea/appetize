import 'package:appetize/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Restaurant.dart';
import 'FrontPage.dart';
import 'globals.dart' as globals;

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png')
};

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('id') == null) {
    await prefs.setString('id', 'test_id_0120301230');
  }

  setRestaurantColors(restaurants);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(FrontPage(restaurants));
}

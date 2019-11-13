import 'package:appetize/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Restaurant.dart';
import 'FrontPage.dart';

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png')
};

void main() {
  setRestaurantColors(restaurants);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(FrontPage(restaurants));
}

import 'dart:math';

import 'package:Appetize/Preferences.dart';
import 'package:Appetize/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FrontPage.dart';
import 'globals.dart' as globals;

void main() async {
  globals.id = 'APPETIZE_0';
  savePreferences();

  setRestaurantColors(globals.restaurants);
  runApp(FrontPage(globals.restaurants));
}

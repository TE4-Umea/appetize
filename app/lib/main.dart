import 'dart:math';

import 'package:Appetize/API.dart';
import 'package:Appetize/Preferences.dart';
import 'package:Appetize/SplashPage.dart';
import 'package:Appetize/colors.dart';
import 'App.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

void main() async {
  await loadPreferences();

  setRestaurantColors(globals.restaurants);
  runApp(App());
  API.getProfile();
}

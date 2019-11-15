library appetize.globals;

import 'package:flutter/cupertino.dart';

import 'Restaurant.dart';

String id;

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png'),
};

// Choosen restaurant is changed by clicking the big buttons uptop, theming is determined by this variable.
ValueNotifier<String> choosenRestaurant = new ValueNotifier<String>('greek');
// Food rating can be between 0-3 (Worst to best) and is changed by the user via the emojis.
ValueNotifier<int> foodRating = new ValueNotifier<int>(-1);

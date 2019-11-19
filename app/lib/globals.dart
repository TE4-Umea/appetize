library appetize.globals;

import 'package:flutter/cupertino.dart';

import 'Restaurant.dart';

String id;
DateTime lastVoteDate = DateTime.now();

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png'),
};

// Choosen restaurant is changed by clicking the big buttons uptop, theming is determined by this variable.
ValueNotifier<String> restaurant = new ValueNotifier<String>('greek');
// Food rating can be between 0-3 (Worst to best) and is changed by the user via the emojis.
ValueNotifier<int> foodRating = new ValueNotifier<int>(-1);

ValueNotifier<String> statusText = new ValueNotifier('Hur var maten idag?');
// 0 - Failed to deliver RED
// 1 - Request sent but not recived YELLOW
// 2 - Request sent and recieved GREEN
ValueNotifier<int> deliverStatus = new ValueNotifier(1);

ValueNotifier<bool> topCardExpanded = new ValueNotifier(true);

var apiTimeout;

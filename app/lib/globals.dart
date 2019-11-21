library appetize.globals;

import 'package:flutter/cupertino.dart';
import 'Restaurant.dart';

const String API_ENDPOINT = 'http://10.0.2.2:5050';

String appetizeId = 'APPETIZE_NULL';
DateTime lastVoteDate = DateTime.now();

List complaints = [];

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png'),
};

// Choosen restaurant is changed by clicking the big buttons uptop, theming is determined by this variable.
ValueNotifier<String> restaurant = new ValueNotifier<String>('greek');
// Food rating can be between 0-3 (Worst to best) and is changed by the user via the emojis.
ValueNotifier<int> foodRating = new ValueNotifier<int>(-1);

ValueNotifier<String> eatTime = new ValueNotifier<String>('-:-');
ValueNotifier<String> regFood = new ValueNotifier<String>('');
ValueNotifier<String> vegFood = new ValueNotifier<String>('');

ValueNotifier<bool> vegetarian = new ValueNotifier<bool>(false);
ValueNotifier<bool> gluten = new ValueNotifier<bool>(false);

ValueNotifier<String> statusText = new ValueNotifier('Hur var maten idag?');

// 0 - Failed to deliver RED
// 1 - Request sent but not recived YELLOW
// 2 - Request sent and recieved GREEN
ValueNotifier<int> deliverStatus = new ValueNotifier(1);

ValueNotifier<bool> topCardExpanded = new ValueNotifier(false);

ValueNotifier<String> signupStatus = new ValueNotifier('');

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

var apiTimeout;

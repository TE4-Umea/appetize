import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

void savePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('id', globals.id);
  await prefs.setString('restaurant', globals.restaurant.value);
  await prefs.setInt('rating', globals.foodRating.value);
}

void loadPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
}

import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

void savePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('appetize_id', globals.appetizeId);
  await prefs.setString('restaurant', globals.restaurant.value);
  await prefs.setInt('rating', globals.foodRating.value);
}

void loadPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  globals.appetizeId = prefs.getString('appetize_id');
}

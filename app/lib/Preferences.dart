import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

void savePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('appetize_id', globals.appetizeId);
  await prefs.setBool('vegetarian', globals.vegetarian.value);
  await prefs.setBool('gluten', globals.gluten.value);
}

void loadPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  globals.appetizeId = prefs.getString('appetize_id');
  globals.vegetarian.value = prefs.getBool('vegetarian');
  globals.gluten.value = prefs.getBool('gluten');
}

import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> GetSharedPreferences() async {
  return await SharedPreferences.getInstance();
}

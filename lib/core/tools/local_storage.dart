import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static late SharedPreferences instance;
}

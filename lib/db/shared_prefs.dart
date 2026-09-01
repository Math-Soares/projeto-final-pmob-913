import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setUserStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('USER', value);
  }

  Future<bool> getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('USER');

    return value ?? false;
  }

  Future<void> setOnBoardSeen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('OnBoardSeen', value);
  }

  Future<bool> getOnBoardSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('OnBoardSeen');

    return value ?? false;
  }
}
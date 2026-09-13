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

  Future<void> setCurrentCity(String value) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('CurrentCity', value);
  }

  Future<String> getCurrentCity() async {
    final p = await SharedPreferences.getInstance();
    return p.getString('CurrentCity') ?? '';
  }

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList('FavoriteCities');

    return value ?? [];
  }

  Future<bool> isFavorite(String value) async {
    List<String> favs = await getFavorites();

    return favs.contains(value);
  }

  Future<void> addFavorite(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = await getFavorites();

    if (!favs.contains(value)) {
      favs.add(value);
      await prefs.setStringList('FavoriteCities', favs);
    }
  }

  Future<void> removeFavorite(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = await getFavorites();

    favs.remove(value);
    await prefs.setStringList('FavoriteCities', favs);
  }
}

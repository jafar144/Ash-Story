import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const tokenLogin = 'TOKEN_LOGIN';

  Future setTokenLogin(String token) async {
    final preferences = await sharedPreferences;
    preferences.setString(tokenLogin, token);
  }

  Future<String?> getTokenLogin() async {
    final preferences = await sharedPreferences;
    return preferences.getString(tokenLogin);
  }

  Future removeTokenLogin() async {
    final preferences = await sharedPreferences;
    preferences.remove(tokenLogin);
  }
}

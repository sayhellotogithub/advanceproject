// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:shared_preferences/shared_preferences.dart';

class TokenSharePref {
  static final String KEY_USER_TOKEN = "userToken";
  static final String KEY_REFRESH_TOKEN = "refreshToken";

  static void saveUserToken(String language) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(KEY_USER_TOKEN, language);
  }

  static Future<String?> getUserToken() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(KEY_USER_TOKEN)) {
      return Future.value(pref.getString(KEY_USER_TOKEN));
    }
    return Future.value(null);
  }

  static void saveRefreshToken(String refreshToken) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(KEY_REFRESH_TOKEN, refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(KEY_REFRESH_TOKEN)) {
      return Future.value(pref.getString(KEY_REFRESH_TOKEN));
    }
    return Future.value(null);
  }

  static Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_REFRESH_TOKEN, "");
    await prefs.setString(KEY_USER_TOKEN, "");
  }
}

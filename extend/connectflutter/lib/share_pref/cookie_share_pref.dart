// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:shared_preferences/shared_preferences.dart';

class CookieSharePref {
  static final COOKIE = "Cookie";

  static void saveCookie(String language) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(COOKIE, language);
  }

  static Future<String?> getCookie() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(COOKIE)) {
      return Future.value(pref.getString(COOKIE));
    }
    return Future.value(null);
  }
}

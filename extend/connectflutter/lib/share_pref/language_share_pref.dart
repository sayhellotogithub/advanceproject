// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:shared_preferences/shared_preferences.dart';

class LanguageSharePref {
  static final LANGUAGE = "language";

  // SharedPreferencesインスタンスを保持
  static late SharedPreferences _prefs;

  // 初期化メソッド（最初に呼び出す必要がある）
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveLanguage(String language) async {
    await _prefs.setString(LANGUAGE, language);
  }

  static Future<String?> getLanguage() async {
    return _prefs.getString(LANGUAGE);
  }
}

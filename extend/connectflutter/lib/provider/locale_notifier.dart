// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/l10n/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 共有環境設定プロバイダー
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferencesをmainで初期化する必要があります');
});

class LocaleNotifier extends StateNotifier<Locale?> {
  static const Locale _defaultLocale = Locale('en');
  static const String _localeKey = 'app_locale';
  final Ref _ref;

  LocaleNotifier(this._ref) : super(null) {
    _loadSavedLocale();
  }

  // 保存された言語設定を読み込む
  Future<void> _loadSavedLocale() async {
    final prefs = _ref.read(sharedPreferencesProvider);
    final String? languageCode = prefs.getString(_localeKey);

    if (languageCode != null) {
      state = Locale(languageCode);
    } else {
      state = _defaultLocale;
    }
  }

  void setLocale(Locale locale) async {
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.setString(_localeKey, locale.languageCode);
    state = locale;
  }

  Future<void> useSystemLocale(BuildContext context) async {
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.remove(_localeKey);

    final deviceLocale = Localizations.localeOf(context);
    final supportedLocales = AppLocalizations.supportedLocales;

    // システム言語がサポートされているか確認
    if (supportedLocales.any(
      (locale) => locale.languageCode == deviceLocale.languageCode,
    )) {
      state = deviceLocale;
    } else {
      state = _defaultLocale;
    }
  }

  /// 如果App设置了语言，则以App为准
  ///如果没有设置语言，以系统为准
  ///如果系统的语言不支持，则默认语言为English
  Locale getCurrentLocale(BuildContext context) {
    // アプリ設定がある場合
    if (state != null) {
      return state!;
    }

    // システム言語を確認
    final deviceLocale = Localizations.localeOf(context);
    final supportedLocales = AppLocalizations.supportedLocales;

    // システム言語がサポートされているか確認
    if (supportedLocales.any(
      (locale) => locale.languageCode == deviceLocale.languageCode,
    )) {
      return deviceLocale;
    }

    // サポートされていない場合はデフォルト(英語)
    return _defaultLocale;
  }

  String getLanguageString(String language) {
    switch (language) {
      case "en":
        return "English";
      case "zh":
        return "简体中文";
      case "ja":
        return "日本語";
      default:
        return "English";
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier(ref);
});

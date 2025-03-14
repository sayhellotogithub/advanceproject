// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------
import 'dart:async';

import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/text_util.dart';

class AppStateManager {
  bool _initialized = false;
  bool _loggedIn = false;
  String? path;

  bool get isLoggedIn => _loggedIn;

  bool get isInitialized => _initialized;
  String? userToken;

  void initializeApp(WidgetRef ref) async {
    userToken = (await TokenSharePref.getUserToken());
    _loggedIn = !TextUtil.isEmpty(userToken);
    await Future.delayed(const Duration(milliseconds: 2000), () {
      _setSplashFinished(ref);
    });
  }

  void changePath(String path) {
    this.path = path;
  }

  void _setSplashFinished(WidgetRef ref) {
    _initialized = true;
    final router = ref.read(routerProvider);
    if (_loggedIn) {
      router.go(homePath);
    } else {
      router.go(loginPath);
    }
  }

  void loginSuccess() async {
    _loggedIn = true;
  }

  void logout(WidgetRef ref) async {
    await TokenSharePref.invalidate();
    _loggedIn = false;
    ref.read(routerProvider).go(loginPath);
  }
}

final appStateManagerProvider =
    StateNotifierProvider<AppStateNotifier, AppStateManager>((ref) {
      final appStateManager = AppStateManager();
      return AppStateNotifier(appStateManager);
    });

class AppStateNotifier extends StateNotifier<AppStateManager> {
  AppStateNotifier(AppStateManager state) : super(state);

  void changePath(String path) {
    state.changePath(path);
    state = state;
  }

  void loginSuccess() {
    state.loginSuccess();
    state = state;
  }

  Future<void> logout(WidgetRef ref) async {
    state.logout(ref);
    state = state;
  }

  void initializeApp(WidgetRef ref) {
    state.initializeApp(ref);
    state = state;
  }
}

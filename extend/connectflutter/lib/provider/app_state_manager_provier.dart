// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------
import 'dart:async';

import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/log_util.dart';
import '../util/text_util.dart';

class AppStateManager {
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;

  String? userToken;

  Future<void> initializeApp(WidgetRef ref) async {
    userToken = await TokenSharePref.getUserToken();
    _loggedIn = !TextUtil.isEmpty(userToken);
    final router = ref.read(routerProvider);
    if (_loggedIn) {
      router.go(homePath);
    } else {
      router.go(loginPath);
    }
  }
}

final appStateManagerProvider =
    StateNotifierProvider<AppStateNotifier, AppStateManager>((ref) {
      final appStateManager = AppStateManager();
      return AppStateNotifier(appStateManager);
    });

class AppStateNotifier extends StateNotifier<AppStateManager> {
  AppStateNotifier(AppStateManager state) : super(state);

  void loginSuccess() {
    state =
        AppStateManager()
          .._loggedIn = true
          ..userToken = state.userToken;
  }

  Future<void> logout(WidgetRef ref) async {
    await TokenSharePref.invalidate();
    // 直接新しい状態を設定
    state = AppStateManager();
    ref.read(routerProvider).replace(loginPath);
  }

  Future<void> initializeApp(WidgetRef ref) async {
    await state.initializeApp(ref);
    AppLogger().debug("initializeApp");
    state =
        AppStateManager()
          .._loggedIn = state._loggedIn
          ..userToken = state.userToken;
  }
}

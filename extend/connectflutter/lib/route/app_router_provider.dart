// 路由状态的Provider
import 'package:connectflutter/page/fav/game/blue_page.dart';
import 'package:connectflutter/page/fav/game/connect_page.dart';
import 'package:connectflutter/page/fav/game/shogi_board.dart';
import 'package:connectflutter/page/fav/game/test_ban.dart';
import 'package:connectflutter/page/login/auth_code_page.dart';
import 'package:connectflutter/page/login/forget_password_main_page.dart';
import 'package:connectflutter/page/login/reset_password_page.dart';
import 'package:connectflutter/page/mine/mine_page.dart';
import 'package:connectflutter/page/mine/setting_page.dart';
import 'package:connectflutter/page/theme/change_icon_page.dart';
import 'package:connectflutter/page/theme/status_bar_configuration_guide_page.dart';
import 'package:connectflutter/page/widget/checkbox/cupertino_checkbox_example.dart';
import 'package:connectflutter/page/widget/slide_segment/slide_segmented_control_page.dart';
import 'package:connectflutter/page/widget/switch/cupertino_switch_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../page/account_main_page.dart';
import '../page/fav/game/ball_game_page.dart';
import '../page/fav/game/goban_page.dart';
import '../page/home_page.dart';
import '../page/login/password_login_page.dart';
import '../page/mine/set_language_page_new.dart';
import '../page/open_account_step/authentication_email_page.dart';
import '../page/open_account_step/authentication_phone_page.dart';
import '../page/open_account_step/electronic_signature_landscape_page.dart';
import '../page/open_account_step/electronic_signature_page.dart';
import '../page/open_account_step/open_account_introduce_page.dart';
import '../page/open_account_step/upload_bank_page.dart';
import '../page/video/video_ad_page.dart';
import '../provider/app_state_manager_provier.dart';
import '../util/index.dart';
import 'router_notifier.dart';

const String splashPath = '/splash';
const String loginPath = '/login';
const String homePath = "/home";
const String accountMainPage = "/accountMainPage";
const String settingsPath = '/settings';
const String minePath = "/mine";
const String setLanguagePath = "/setLanguage";
const String passwordLoginPath = "/passwordLogin";
const String forgetPasswordPath = "/forgetPassword";
const String authCodePath = "/authCode";
const String resetPasswordPath = "/resetPassword";
const String electronicSignaturePath = "/electronicSign";
const String electronicSignatureLandscapePath = "/electronicSignLandscape";
const String uploadBankPath = "/uploadBank";
const String openAccountIntroductionPath = "/openAccountIntroduction";
const String authenticationPhone = "/authenticationPhone";
const String authenticationEmailPath = "/authenticationEmail";
const String logoutPath = "/logout";
const String videoAdPath = "/videoAd";

//widget
const String cupertinoCheckboxPath = "/widget/checkbox/cupertinoCheckbox";
const String cupertinoSwitchPath = "/widget/switch/cupertinoSwitch";
const String gobanPath = "/fav/game/goban";
const String statusBarCongigurationGuidePath =
    "/theme/statusBarCongigurationGuide";

const String bluetoothPath = "/fav/game/bluetooth";
const String shogiBoardPath = "/fav/game/shogiboard";
const String connectPath = "/fav/game/connect";
const String testPath = "/fav/game/test";
const String ballPath = "/fav/game/ball";
const String changeIconPath = "/theme/changeIcon";
const String slideSegmentedControlPath =
    "/widget/segmentedControl/slideSegmentedControl";

final routerNotifier = RouterNotifier();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: loginPath,
        builder: (context, state) => PasswordLoginPage(),
      ),
      GoRoute(path: homePath, builder: (context, state) => HomePage()),
      GoRoute(
        path: accountMainPage,
        builder: (context, state) => AccountMainPage(),
      ),
      GoRoute(path: settingsPath, builder: (context, state) => SettingPage()),
      GoRoute(path: minePath, builder: (context, state) => MinePage()),
      GoRoute(
        path: setLanguagePath,
        builder: (context, state) => SetLanguagePageNew(),
      ),
      GoRoute(
        path: passwordLoginPath,
        builder: (context, state) => PasswordLoginPage(),
      ),
      GoRoute(
        path: forgetPasswordPath,
        builder: (context, state) => ForgetPasswordMainPage(),
      ),
      GoRoute(
        path: authCodePath,
        builder: (context, state) => AuthCodePage(token: "", account: ""),
      ),
      GoRoute(
        path: resetPasswordPath + '/:account/:bizToken',
        builder:
            (context, state) => ResetPasswordPage(account: "", bizToken: ""),
      ),
      GoRoute(
        path: electronicSignaturePath,
        builder: (context, state) => ElectronicSignaturePage(),
      ),
      GoRoute(
        path: electronicSignatureLandscapePath,
        builder: (context, state) => ElectroniceSignatureLandscapePage(),
      ),
      GoRoute(
        path: uploadBankPath,
        builder: (context, state) => UploadBankPage(),
      ),
      GoRoute(
        path: openAccountIntroductionPath,
        builder: (context, state) => OpenAccountIntroducePage(),
      ),
      GoRoute(
        path: authenticationPhone,
        builder: (context, state) => AuthenticationPhonePage(),
      ),
      GoRoute(
        path: authenticationEmailPath,
        builder: (context, state) => AuthenticationEmailPage(),
      ),
      GoRoute(path: videoAdPath, builder: (context, state) => VideoAdPage()),
      GoRoute(
        path: cupertinoCheckboxPath,
        builder: (context, state) => CupertinoCheckboxExample(),
      ),
      GoRoute(
        path: cupertinoSwitchPath,
        builder: (context, state) => CupertinoSwitchExample(),
      ),
      GoRoute(path: gobanPath, builder: (context, state) => GoBanPage()),
      GoRoute(
        path: statusBarCongigurationGuidePath,
        builder: (context, state) => StatusBarConfigurationGuidePage(),
      ),
      GoRoute(path: bluetoothPath, builder: (context, state) => BluePage()),
      GoRoute(
        path: shogiBoardPath,
        builder: (context, state) {
          final String playerId = state.extra as String;
          return ShogiBoard(myPlayerId: playerId);
        },
      ),
      GoRoute(path: connectPath, builder: (context, state) => ConnectPage()),
      GoRoute(path: testPath, builder: (context, state) => TestPage()),
      GoRoute(path: ballPath, builder: (context, state) => BallGamePage()),
      GoRoute(
        path: changeIconPath,
        builder: (context, state) => ChangeIconPage(),
      ),
      GoRoute(
        path: slideSegmentedControlPath,
        builder: (context, state) => SlideSegmentedControlPage(),
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('Page not found'))),
    redirect: (context, state) {
      final appState = ref.read(appStateManagerProvider);

      // ログインしていない場合は /login にリダイレクト
      final isLoggingIn = state.fullPath == loginPath;
      if (!appState.isLoggedIn && !isLoggingIn) {
        return loginPath;
      }
      // すでにログインしていて /login にアクセスしようとした場合はホームへ
      if (appState.isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
    debugLogDiagnostics: true,
    observers: [routerNotifier],
  );
});

void safeGoBack(BuildContext context) {
  final canPop = GoRouter.of(context).canPop();

  if (canPop) {
    context.pop();
  } else {
    BotToast.showText(text: "Can't go back");
  }
}

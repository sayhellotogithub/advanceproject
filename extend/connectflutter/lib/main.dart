// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/provider/app_state_manager_provier.dart';
import 'package:connectflutter/provider/game/borad_state.dart';
import 'package:connectflutter/provider/game/lan_connection_service.dart';
import 'package:connectflutter/provider/locale_notifier.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:connectflutter/util/phone_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/index.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // スプラッシュを保持

  // SharedPreferencesを初期化
  final sharedPreferences = await SharedPreferences.getInstance();
  StatusBarUtil.setPreferredOrientations();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PhoneUtil.initSystem();

    ref.read(lanConnectionProvider).onMessage = (msg) {
      AppLogger().debug(msg.toString());
      if (msg['type'] == 'move') {
        final pieceId = msg['pieceId'];
        final x = msg['x'];
        final y = msg['y'];

        ref.read(boardProvider.notifier).applyRemoteMove(pieceId, x, y);
      }
    };
    // 非同期初期化を待機
    ref.watch(appStateManagerProvider.notifier).initializeApp(ref).then((_) {
      FlutterNativeSplash.remove(); // スプラッシュ削除
    });

    final locale = ref.watch(localeProvider);
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: router,
          builder: BotToastInit(),
          locale: locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
        );
      },
    );
  }
}

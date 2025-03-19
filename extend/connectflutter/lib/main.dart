// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:bot_toast/bot_toast.dart';

import 'package:connectflutter/provider/app_state_manager_provier.dart';
import 'package:connectflutter/provider/locale_notifier.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/phone_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    final initialization = ref
        .watch(appStateManagerProvider.notifier)
        .initializeApp(ref);

    initialization.then((_) => FlutterNativeSplash.remove()); // 🔹 スプラッシュ削除

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

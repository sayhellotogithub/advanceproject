// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:bot_toast/bot_toast.dart';
import 'package:connectflutter/provider/locale_notifier.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/phone_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/index.dart';

void main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferencesを初期化
  final sharedPreferences = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: MyApp(),
      ),
    );
  });
}

void _setupLogging() {
  Logger.level = Level.all;
  Logger.addLogListener((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PhoneUtil.initSystem();
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ref) {
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

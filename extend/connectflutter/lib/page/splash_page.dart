// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_state_manager_provier.dart';

class SplashPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashPage> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("This is splash widget"))),
    );
  }

  @override
  void didChangeDependencies() {
    ref.read(appStateManagerProvider.notifier).initializeApp(ref);
    super.didChangeDependencies();
  }
}

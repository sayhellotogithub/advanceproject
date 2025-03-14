// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:flutter/cupertino.dart';

/// 封装成
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  FocusScopeNode? _currentFocus;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _currentFocus = FocusScope.of(context);
    super.didChangeDependencies();
  }
}

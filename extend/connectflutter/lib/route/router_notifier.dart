// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class RouterNotifier extends NavigatorObserver {
  final List<Route<dynamic>> _routeStack = [];

  bool get canPop => _routeStack.length > 1;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.removeLast();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final index = _routeStack.indexOf(oldRoute!);
    if (index != -1) {
      _routeStack[index] = newRoute!;
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

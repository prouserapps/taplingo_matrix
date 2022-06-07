import 'package:flutter/material.dart';
import 'package:taplingo_matrix/core/routes/navigation_route.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static Future<T?>? push<T extends Object>(NavigationRoute navigationRoute) {
    return navigatorKey.currentState
        ?.pushNamed(navigationRoute.name, arguments: navigationRoute);
  }

  static Future<T?>? pushReplacement<T extends Object>(
      NavigationRoute navigationRoute) {
    return navigatorKey.currentState?.pushReplacementNamed(
      navigationRoute.name,
      arguments: navigationRoute,
    );
  }

  static Future<T?>? pushAndRemoveUntil<T extends Object>(
      NavigationRoute navigationRoute, RoutePredicate routePredicate) {
    popUntil(navigationRoute.name, routePredicate: routePredicate);

    return push(navigationRoute);
  }

  static void popUntil<T extends Object>(
    String name, {
    inclusive = false,
    RoutePredicate? routePredicate,
  }) {
    bool poppedSelf = false;

    navigatorKey.currentState?.popUntil(
      (routePredicate != null)
          ? routePredicate
          : (route) {
              if (route.settings.name == name) {
                if (inclusive) {
                  poppedSelf = true;
                  return false;
                } else {
                  return true;
                }
              }

              return poppedSelf || false;
            },
    );
  }

  static void pop<T extends Object>() {
    return navigatorKey.currentState?.pop();
  }

  static bool canPop<T extends Object>() {
    final currentState = navigatorKey.currentState;
    if (currentState == null) {
      return false;
    }
    return currentState.canPop();
  }

  static Future<T?>? pushAndRemoveAll<T extends Object>(
    NavigationRoute navigationRoute,
  ) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      navigationRoute.route as dynamic,
      (_) => false,
    );
  }
}

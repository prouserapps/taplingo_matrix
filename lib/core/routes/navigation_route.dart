import 'package:flutter/widgets.dart';

abstract class NavigationRoute {
  late final String name;
  late final Route<dynamic> route;
  final bool fullScreen;

  NavigationRoute(
    this.name,
    this.route, {
    this.fullScreen = false,
  });

  Route<dynamic> build() {
    return route;
  }
}

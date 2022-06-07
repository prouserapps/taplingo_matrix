import 'package:flutter/widgets.dart';

abstract class RouteTransitions {
  static const Duration DEFAULT_DURATION = Duration(
    milliseconds: 500,
  );

  // ignore: non_constant_identifier_names
  static SlideTransition EASE_IN(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = const Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    Tween<Offset> tween = Tween(begin: begin, end: end);
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }

  // ignore: non_constant_identifier_names
  static const RouteTransitionsBuilder DEFAULT_TRANSITION = EASE_IN;

  RouteTransitions._();
}

import 'package:flutter/widgets.dart';
import 'package:taplingo_matrix/core/routes/navigation_route.dart';
import 'package:taplingo_matrix/core/routes/route_transition.dart';
import 'package:taplingo_matrix/core/service_locator/service_locator_config.dart';
import 'package:taplingo_matrix/modules/onboarding/ui/onboarding_screen.dart';

class OnboardingRoute extends NavigationRoute {
  static String path = "/onboarding";

  OnboardingRoute._(Route<Object> route)
      : super(
          path,
          route,
          fullScreen: true,
        );

  static OnboardingRoute of({
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionsBuilder,
    bool animated = true,
  }) {
    OnboardingScreen _screen = OnboardingScreen(
      fetchOnboardingInputPort: ServiceLocatorConfig.provide(),
    );

    if (animated) {
      return OnboardingRoute._(
        PageRouteBuilder(
          settings: RouteSettings(name: path),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              _screen,
          transitionDuration:
              transitionDuration ?? RouteTransitions.DEFAULT_DURATION,
          transitionsBuilder:
              transitionsBuilder ?? RouteTransitions.DEFAULT_TRANSITION,
        ),
      );
    }

    return OnboardingRoute._(
      PageRouteBuilder(
        settings: RouteSettings(name: path),
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) =>
            _screen,
      ),
    );
  }
}

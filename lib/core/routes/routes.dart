import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:taplingo_matrix/core/routes/navigation_route.dart';
import 'package:taplingo_matrix/modules/onboarding/navigation/routes/onboarding_route.dart';

class Routes {
  const Routes._();

  static CustomRoute generateRoute(
    bool isOutdated,
  ) {
    return (final RouteSettings settings) {
      late NavigationRoute navigationRoute;

      if (settings.arguments == null) {
        navigationRoute = OnboardingRoute.of();
      } else {
        navigationRoute = settings.arguments as NavigationRoute;
      }

      if (navigationRoute.fullScreen) {
        //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      } else {
        SystemChrome.setEnabledSystemUIOverlays([
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ]);
      }

      return navigationRoute.build();
    };
  }
}

typedef CustomRoute = Route<dynamic>? Function(RouteSettings settings);

import 'package:taplingo_matrix/core/directions/screen_directions.dart';
import 'package:taplingo_matrix/core/routes/app_navigator.dart';
import 'package:taplingo_matrix/modules/login/navigation/routes/login_route.dart';
import 'package:taplingo_matrix/modules/onboarding/ui/onboarding_screen.dart';

class OnboardingScreenDirections extends ScreenDirection {
  OnboardingScreenDirections(
    OnboardingScreen screen,
  ) : super(screen);

  void goToLogin() {
    AppNavigator.pushReplacement(LoginRoute.of());
  }
}

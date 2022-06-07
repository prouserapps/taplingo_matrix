import 'package:taplingo_matrix/core/domain/onboarding.dart';

abstract class FetchOnboardingInputPort {
  Stream<List<Onboarding>> fetchOnboarding();
}

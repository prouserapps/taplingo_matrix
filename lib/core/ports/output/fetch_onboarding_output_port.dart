import 'package:taplingo_matrix/core/domain/onboarding.dart';

abstract class FetchOnboardingOutputPort {
  Stream<List<Onboarding>> fetchOnboarding();
}

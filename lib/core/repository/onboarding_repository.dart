import 'package:injectable/injectable.dart';
import 'package:taplingo_matrix/core/domain/onboarding.dart';
import 'package:taplingo_matrix/core/ports/output/fetch_onboarding_output_port.dart';

@singleton
class OnboardingRepository implements FetchOnboardingOutputPort {
  @override
  Stream<List<Onboarding>> fetchOnboarding() {
    List<Onboarding> onboardingInfo = [];

    for (int i = 0; i < 50; i++) {
      onboardingInfo.add(Onboarding(
        title: 'welcome #$i',
        description: 'just a simple description #$i',
      ));
    }

    return Stream.value(onboardingInfo);
  }
}

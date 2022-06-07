import 'package:injectable/injectable.dart';
import 'package:taplingo_matrix/core/domain/onboarding.dart';
import 'package:taplingo_matrix/core/ports/input/fetch_onboarding_input_port.dart';
import 'package:taplingo_matrix/core/ports/output/fetch_onboarding_output_port.dart';

@singleton
class FetchOnboardingUseCase implements FetchOnboardingInputPort {
  const FetchOnboardingUseCase(this._outputPort);

  final FetchOnboardingOutputPort _outputPort;

  @override
  Stream<List<Onboarding>> fetchOnboarding() {
    return _outputPort.fetchOnboarding();
  }
}

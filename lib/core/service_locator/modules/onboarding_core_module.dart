import 'package:injectable/injectable.dart';
import 'package:taplingo_matrix/core/ports/input/fetch_onboarding_input_port.dart';
import 'package:taplingo_matrix/core/ports/output/fetch_onboarding_output_port.dart';
import 'package:taplingo_matrix/core/repository/onboarding_repository.dart';
import 'package:taplingo_matrix/core/usecase/fetch_onboarding_use_case.dart';

@module
abstract class OnboardingCoreModule {
  @singleton
  FetchOnboardingInputPort fetchOnboardingInputPort(
    FetchOnboardingUseCase useCase,
  ) =>
      useCase;

  @singleton
  FetchOnboardingOutputPort fetchOnboardingOutputPort(
    OnboardingRepository repository,
  ) =>
      repository;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../ports/input/fetch_onboarding_input_port.dart' as _i6;
import '../ports/output/fetch_onboarding_output_port.dart' as _i4;
import '../repository/onboarding_repository.dart' as _i3;
import '../usecase/fetch_onboarding_use_case.dart' as _i5;
import 'modules/onboarding_core_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final onboardingCoreModule = _$OnboardingCoreModule();
  gh.singleton<_i3.OnboardingRepository>(_i3.OnboardingRepository());
  gh.singleton<_i4.FetchOnboardingOutputPort>(onboardingCoreModule
      .fetchOnboardingOutputPort(get<_i3.OnboardingRepository>()));
  gh.singleton<_i5.FetchOnboardingUseCase>(
      _i5.FetchOnboardingUseCase(get<_i4.FetchOnboardingOutputPort>()));
  gh.singleton<_i6.FetchOnboardingInputPort>(onboardingCoreModule
      .fetchOnboardingInputPort(get<_i5.FetchOnboardingUseCase>()));
  return get;
}

class _$OnboardingCoreModule extends _i7.OnboardingCoreModule {}

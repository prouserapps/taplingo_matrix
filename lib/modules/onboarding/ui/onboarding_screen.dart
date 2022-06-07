import 'package:flutter/material.dart';
import 'package:taplingo_matrix/core/domain/onboarding.dart';
import 'package:taplingo_matrix/core/ports/input/fetch_onboarding_input_port.dart';
import 'package:taplingo_matrix/modules/onboarding/navigation/directions/onboarding_screen_directions.dart';

part './components/onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    required this.fetchOnboardingInputPort,
    Key? key,
  }) : super(key: key);

  final FetchOnboardingInputPort fetchOnboardingInputPort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Onboarding'),
        ),
        body: StreamBuilder<List<Onboarding>>(
          stream: fetchOnboardingInputPort.fetchOnboarding(),
          builder: (context, snapshot) {
            final onboarding = snapshot.data;

            if (onboarding == null) {
              return _loading();
            }

            return ListView.builder(
              itemCount: onboarding.length,
              itemBuilder: (context, index) {
                return _OnboardingItem(
                  onboarding: onboarding[index],
                  onTap: _redirectToLogin,
                );
              },
            );
          },
        ));
  }

  void _redirectToLogin() {
    OnboardingScreenDirections(this).goToLogin();
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

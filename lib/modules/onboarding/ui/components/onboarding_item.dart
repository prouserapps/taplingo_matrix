part of 'package:taplingo_matrix/modules/onboarding/ui/onboarding_screen.dart';

class _OnboardingItem extends StatelessWidget {
  const _OnboardingItem({
    required this.onboarding,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Onboarding onboarding;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: ListTile(
        title: Text(onboarding.title),
        subtitle: Text(onboarding.description),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => onTap.call(),
        ),
      ),
    );
  }
}

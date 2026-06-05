import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static String id = "OnboardingView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: OnboardingViewBody()),
      ),
    );
  }
}

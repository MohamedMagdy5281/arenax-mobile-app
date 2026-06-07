import 'dart:async';

import 'package:arenax_mobile_app/core/utils/functions/onboarding_check.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/auth_intro_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
part 'onboarding_notifier_provider.g.dart';

class OnboardingState {
  final int currentPage;

  const OnboardingState({
    required this.currentPage,
  });

  OnboardingState copyWith({
    int currentPage = 0,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    return const OnboardingState(currentPage: 0);
  }

  Future<void> nextCurrentPage() async {
    if (state.currentPage < 2) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    } else {
      await AppPreferences.setOnboardingCompleted();
      globals.navigatorKey.currentState!.pushReplacementNamed(AuthIntroView.id);
    }
  }

  Future<void> skipOnboarding() async {
    await AppPreferences.setOnboardingCompleted();
    globals.navigatorKey.currentState!.pushReplacementNamed(AuthIntroView.id);
  }

  Future<void> previousCurrentPage() async {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  Future<void> changeCurrentPageOnTap(int index) async {
    state = state.copyWith(currentPage: index);
  }
}

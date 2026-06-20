import 'dart:async';

import 'package:arenax_mobile_app/core/utils/functions/app_settings_dialog.dart';
import 'package:arenax_mobile_app/core/utils/functions/onboarding_check.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/auth_intro_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/onboarding_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
part 'profile_notifier_provider.g.dart';

class ProfileState {
  final bool isPageLoading;

  const ProfileState({
    this.isPageLoading = false,
  });

  ProfileState copyWith({
    bool? isPageLoading,
  }) {
    return ProfileState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
    );
  }
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }
}

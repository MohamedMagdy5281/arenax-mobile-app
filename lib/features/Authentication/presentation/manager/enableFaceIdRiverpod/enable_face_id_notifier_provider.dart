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
part 'enable_face_id_notifier_provider.g.dart';

class EnableFaceIdState {
  final bool isPageLoading;
  final bool isEnableFaceIdButtonLoading;
  final bool isNotNowButtonLoading;

  const EnableFaceIdState(
      {this.isPageLoading = false,
      this.isEnableFaceIdButtonLoading = false,
      this.isNotNowButtonLoading = false});

  EnableFaceIdState copyWith(
      {bool? isPageLoading,
      bool? isEnableFaceIdButtonLoading,
      bool? isNotNowButtonLoading}) {
    return EnableFaceIdState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isEnableFaceIdButtonLoading:
          isEnableFaceIdButtonLoading ?? this.isEnableFaceIdButtonLoading,
      isNotNowButtonLoading:
          isNotNowButtonLoading ?? this.isNotNowButtonLoading,
    );
  }
}

@riverpod
class EnableFaceIdNotifier extends _$EnableFaceIdNotifier {
  @override
  EnableFaceIdState build() {
    return const EnableFaceIdState();
  }

  Future<void> toggleIsPageLoading() async {
    state = state.copyWith(isPageLoading: !state.isPageLoading);
  }

  Future<void> toggleIsEnableFaceIdButtonLoading() async {
    state = state.copyWith(
        isEnableFaceIdButtonLoading: !state.isEnableFaceIdButtonLoading);
  }

  Future<void> toggleIsNotNowButtonLoading() async {
    state = state.copyWith(isNotNowButtonLoading: !state.isNotNowButtonLoading);
  }
}

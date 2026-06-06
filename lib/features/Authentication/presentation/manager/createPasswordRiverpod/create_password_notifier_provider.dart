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
part 'create_password_notifier_provider.g.dart';

class CreatePasswordState {
  final bool showPassword;
  final bool showConfirmPassword;
  final bool isPageLoading;
  final bool isCreatePasswordButtonLoading;

  const CreatePasswordState(
      {this.showPassword = false,
      this.showConfirmPassword = false,
      this.isPageLoading = false,
      this.isCreatePasswordButtonLoading = false});

  CreatePasswordState copyWith(
      {bool? showPassword,
      bool? showConfirmPassword,
      bool? isPageLoading,
      bool? isCreatePasswordButtonLoading}) {
    return CreatePasswordState(
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isCreatePasswordButtonLoading:
          isCreatePasswordButtonLoading ?? this.isCreatePasswordButtonLoading,
    );
  }
}

@riverpod
class CreatePasswordNotifier extends _$CreatePasswordNotifier {
  @override
  CreatePasswordState build() {
    return const CreatePasswordState();
  }

  Future<void> toggleShowPassword() async {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  Future<void> toggleConfirmShowPassword() async {
    state = state.copyWith(showConfirmPassword: !state.showConfirmPassword);
  }

  Future<void> toggleIsPageLoading() async {
    state = state.copyWith(isPageLoading: !state.isPageLoading);
  }

  Future<void> toggleIsCreatePasswordButtonLoading() async {
    state = state.copyWith(
        isCreatePasswordButtonLoading: !state.isCreatePasswordButtonLoading);
  }
}

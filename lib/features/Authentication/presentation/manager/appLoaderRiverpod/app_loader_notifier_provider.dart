import 'dart:async';

import 'package:arenax_mobile_app/core/utils/functions/app_settings_dialog.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
part 'app_loader_notifier_provider.g.dart';

class AppLoaderState {
  final Position? position;
  final bool permissionDenied;
  final bool serviceDisabled;

  const AppLoaderState({
    this.position,
    this.permissionDenied = false,
    this.serviceDisabled = false,
  });

  AppLoaderState copyWith({
    Position? position,
    bool? permissionDenied,
    bool? serviceDisabled,
  }) {
    return AppLoaderState(
      position: position ?? this.position,
      permissionDenied: permissionDenied ?? this.permissionDenied,
      serviceDisabled: serviceDisabled ?? this.serviceDisabled,
    );
  }
}

@riverpod
class AppLoaderNotifier extends _$AppLoaderNotifier {
  StreamSubscription<Position>? _positionStream;

  @override
  AppLoaderState build() {
    return const AppLoaderState();
  }

  Future<void> initLocation() async {
    LocationPermission permission;
    LatLng? userLocation;
    final context = globals.navigatorKey.currentContext;

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (context != null) {
        showAppSettingsDialog(
          context,
          content: AppLocalizations.of(context)!.locationPermissionSettings,
        );
      }
      return;
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Get user's current location
      Position position = await Geolocator.getCurrentPosition();
      userLocation = LatLng(position.latitude, position.longitude);

      globals.userPosition = userLocation;
      globals.navigatorKey.currentState!.pushReplacementNamed(LoginView.id);
    }
  }
}

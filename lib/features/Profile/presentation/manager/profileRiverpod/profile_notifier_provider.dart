import 'dart:async';

import 'package:arenax_mobile_app/core/utils/functions/app_settings_dialog.dart';
import 'package:arenax_mobile_app/core/utils/functions/onboarding_check.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/auth_intro_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_notifier_provider.g.dart';

class ProfileState {
  final bool isPageLoading;

  final ThemeMode themeMode;
  final Locale? locale;

  final bool isThemeFromStorage;
  final bool isLocaleFromStorage;

  const ProfileState({
    this.isPageLoading = false,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.isThemeFromStorage = false,
    this.isLocaleFromStorage = false,
  });

  ProfileState copyWith({
    bool? isPageLoading,
    ThemeMode? themeMode,
    Locale? locale,
    bool? isThemeFromStorage,
    bool? isLocaleFromStorage,
  }) {
    return ProfileState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isThemeFromStorage: isThemeFromStorage ?? this.isThemeFromStorage,
      isLocaleFromStorage: isLocaleFromStorage ?? this.isLocaleFromStorage,
    );
  }
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    init();
    return const ProfileState();
  }

  // ================= INIT =================
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final theme = prefs.getString('theme_mode');
    final lang = prefs.getString('locale');

    if (lang != null) {
      // ✅ SP has a value -> globals.appLang matches it exactly
      globals.appLang = lang;
    } else {
      // ✅ SP is null -> globals.appLang follows the system language
      final systemLang =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      globals.appLang = systemLang == 'ar' ? 'ar' : 'en';
    }

    state = ProfileState(
      themeMode: _mapTheme(theme),
      locale: lang != null ? Locale(lang) : null,
      isThemeFromStorage: theme != null,
      isLocaleFromStorage: lang != null,
    );
  }

  // THEME TOGGLE
  Future<void> toggleTheme() async {
    state = state.copyWith(isPageLoading: true);
    final prefs = await SharedPreferences.getInstance();

    // ✅ resolve the actual *displayed* theme first — if nothing's stored,
    // the visible theme follows system brightness, not the ThemeMode.system
    // enum value itself
    final isDarkNow = state.isThemeFromStorage
        ? state.themeMode == ThemeMode.dark
        : WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    final next = isDarkNow ? ThemeMode.light : ThemeMode.dark;

    await prefs.setString('theme_mode', next.name);

    state = state.copyWith(
      themeMode: next,
      isThemeFromStorage: true,
    );
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(isPageLoading: false);
    });
  }

  Future<void> toggleLang() async {
    state = state.copyWith(isPageLoading: true);

    final prefs = await SharedPreferences.getInstance();

    // ✅ resolve effective current language first — stored value if we have
    // one, otherwise fall back to what the device is actually set to
    final currentLang = state.locale?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    final nextLang = currentLang == 'ar' ? 'en' : 'ar';

    await prefs.setString('locale', nextLang);

    globals.appLang = nextLang;

    state = state.copyWith(
      locale: Locale(nextLang),
      isLocaleFromStorage: true,
    );
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(isPageLoading: false);
    });
  }

  String getThemeSubtitle(ProfileState s, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final systemThemeText = isDark
        ? globals.appLang == "ar"
            ? "داكن"
            : "Dark"
        : globals.appLang == "ar"
            ? "مضئ"
            : "Light";

    if (!s.isThemeFromStorage) {
      return globals.appLang == "ar"
          ? "النظام ($systemThemeText)"
          : "System ($systemThemeText)";
    }

    return s.themeMode == ThemeMode.dark
        ? globals.appLang == "ar"
            ? "داكن"
            : "Dark"
        : globals.appLang == "ar"
            ? "مضئ"
            : "Light";
  }

  String getLangSubtitle(ProfileState s) {
    final systemLang =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final systemLangText = systemLang == 'ar' ? "العربية" : "English";

    if (!s.isLocaleFromStorage) {
      return "$systemLangText (device)";
    }

    // ✅ safe now — s.locale is guaranteed non-null when isLocaleFromStorage
    // is true, but we use ?. defensively instead of ! to avoid a runtime
    // crash if that invariant is ever violated by future code changes
    return s.locale?.languageCode == 'ar' ? "العربية" : "English";
  }

  ThemeMode _mapTheme(String? theme) {
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

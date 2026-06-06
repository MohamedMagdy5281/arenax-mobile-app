import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color kWhiteColor;
  final Color kBlackColor;

  final Color kPrimaryColor;
  final Color kPrimaryDarkColor;
  final Color kPrimaryLightColor;

  final Color kBackGroundColor;
  final Color kSurfaceColor;

  final Color kAccentColor;
  final Color kAccentTextColor;

  final Color kSuccessColor;
  final Color kSuccessTextColor;
  final Color kSuccessBGColor;

  final Color kWarningColor;
  final Color kWarningTextColor;
  final Color kWarningBGColor;

  final Color kErrorColor;

  final Color kInfoColor;
  final Color kInfoTextColor;
  final Color kInfoBGColor;

  final Color kTextColor;
  final Color kTextMutedColor;

  final Color kHintColor;
  final Color kDisabledButtonColor;

  final Color kCountryCodeBGColor;

  final Color kBorderRoundColor;

  const AppColors({
    required this.kWhiteColor,
    required this.kBlackColor,
    required this.kPrimaryColor,
    required this.kPrimaryDarkColor,
    required this.kPrimaryLightColor,
    required this.kBackGroundColor,
    required this.kSurfaceColor,
    required this.kAccentColor,
    required this.kAccentTextColor,
    required this.kSuccessColor,
    required this.kSuccessTextColor,
    required this.kSuccessBGColor,
    required this.kWarningColor,
    required this.kWarningTextColor,
    required this.kWarningBGColor,
    required this.kErrorColor,
    required this.kInfoColor,
    required this.kInfoTextColor,
    required this.kInfoBGColor,
    required this.kTextColor,
    required this.kTextMutedColor,
    required this.kHintColor,
    required this.kDisabledButtonColor,
    required this.kCountryCodeBGColor,
    required this.kBorderRoundColor,
  });

  static const dark = AppColors(
      kWhiteColor: Colors.white,
      kBlackColor: Colors.black,
      kPrimaryColor: Color(0xFF7B2FF7),
      kPrimaryDarkColor: Color(0xFF241B3D),
      kPrimaryLightColor: Color(0x2EFFFFFF),
      kBackGroundColor: Color(0xFF0E0B16),
      kSurfaceColor: Color(0xFF1A1626),
      kAccentColor: Color(0xFFC2F526),
      kAccentTextColor: Color(0xFF2E3B00),
      kSuccessColor: Color(0xFF19C37D),
      kSuccessTextColor: Color(0xFF5DCAA5),
      kSuccessBGColor: Color(0xFF0E2E25),
      kWarningColor: Color(0xFFFFB020),
      kWarningTextColor: Color(0xFFF5C16B),
      kWarningBGColor: Color(0xFF33260D),
      kErrorColor: Color(0xFFFF4D5E),
      kInfoColor: Color(0xFF3B9DFF),
      kInfoTextColor: Color(0xFF8FC4FF),
      kInfoBGColor: Color(0xFF0C2440),
      kTextColor: Color(0xFFF5F3FA),
      kTextMutedColor: Color(0xFFA9A3BD),
      kHintColor: Color(0xFF6B6577),
      kDisabledButtonColor: Color(0xFF322B45),
      kCountryCodeBGColor: Color(0xFF15121F),
      kBorderRoundColor: Color(0XFF4F4A5E));

  static const light = AppColors(
      kWhiteColor: Colors.white,
      kBlackColor: Colors.black,
      kPrimaryColor: Color(0xFF7B2FF7),
      kPrimaryDarkColor: Color(0xFF5A20B5),
      kPrimaryLightColor: Color(0xFFE8D8FF),
      kBackGroundColor: Color(0xFFF4F1FA),
      kSurfaceColor: Color(0XFFFFFFFF),
      kAccentColor: Color(0xFFA4D61C),
      kAccentTextColor: Color(0xFF1F2A00),
      kSuccessColor: Color(0xFF19C37D),
      kSuccessTextColor: Color(0xFF0F5132),
      kSuccessBGColor: Color(0xFFD1FAE5),
      kWarningColor: Color(0xFFFFB020),
      kWarningTextColor: Color(0xFF8A5A00),
      kWarningBGColor: Color(0xFFFFF4D6),
      kErrorColor: Color(0xFFE53935),
      kInfoColor: Color(0xFF3B9DFF),
      kInfoTextColor: Color(0xFF0A58CA),
      kInfoBGColor: Color(0xFFD6ECFF),
      kTextColor: Color(0xFF15121F),
      kTextMutedColor: Color(0xFF6B6577),
      kHintColor: Color(0xFF948FA3),
      kDisabledButtonColor: Color(0xFFE6E2EF),
      kCountryCodeBGColor: Color(0xFFF8F7FC),
      kBorderRoundColor: Color(0XFFC9C5D4));

  @override
  AppColors copyWith({
    Color? kWhiteColor,
    Color? kBlackColor,
    Color? kPrimaryColor,
    Color? kPrimaryDarkColor,
    Color? kPrimaryLightColor,
    Color? kBackGroundColor,
    Color? kSurfaceColor,
    Color? kAccentColor,
    Color? kAccentTextColor,
    Color? kSuccessColor,
    Color? kSuccessTextColor,
    Color? kSuccessBGColor,
    Color? kWarningColor,
    Color? kWarningTextColor,
    Color? kWarningBGColor,
    Color? kErrorColor,
    Color? kInfoColor,
    Color? kInfoTextColor,
    Color? kInfoBGColor,
    Color? kTextColor,
    Color? kTextMutedColor,
    Color? kHintColor,
    Color? kDisabledButtonColor,
    Color? kCountryCodeBGColor,
    Color? kBorderRoundColor,
  }) {
    return AppColors(
      kWhiteColor: kWhiteColor ?? this.kWhiteColor,
      kBlackColor: kBlackColor ?? this.kBlackColor,
      kPrimaryColor: kPrimaryColor ?? this.kPrimaryColor,
      kPrimaryDarkColor: kPrimaryDarkColor ?? this.kPrimaryDarkColor,
      kPrimaryLightColor: kPrimaryLightColor ?? this.kPrimaryLightColor,
      kBackGroundColor: kBackGroundColor ?? this.kBackGroundColor,
      kSurfaceColor: kSurfaceColor ?? this.kSurfaceColor,
      kAccentColor: kAccentColor ?? this.kAccentColor,
      kAccentTextColor: kAccentTextColor ?? this.kAccentTextColor,
      kSuccessColor: kSuccessColor ?? this.kSuccessColor,
      kSuccessTextColor: kSuccessTextColor ?? this.kSuccessTextColor,
      kSuccessBGColor: kSuccessBGColor ?? this.kSuccessBGColor,
      kWarningColor: kWarningColor ?? this.kWarningColor,
      kWarningTextColor: kWarningTextColor ?? this.kWarningTextColor,
      kWarningBGColor: kWarningBGColor ?? this.kWarningBGColor,
      kErrorColor: kErrorColor ?? this.kErrorColor,
      kInfoColor: kInfoColor ?? this.kInfoColor,
      kInfoTextColor: kInfoTextColor ?? this.kInfoTextColor,
      kInfoBGColor: kInfoBGColor ?? this.kInfoBGColor,
      kTextColor: kTextColor ?? this.kTextColor,
      kTextMutedColor: kTextMutedColor ?? this.kTextMutedColor,
      kHintColor: kHintColor ?? this.kHintColor,
      kDisabledButtonColor: kDisabledButtonColor ?? this.kDisabledButtonColor,
      kCountryCodeBGColor: kCountryCodeBGColor ?? this.kCountryCodeBGColor,
      kBorderRoundColor: kBorderRoundColor ?? this.kBorderRoundColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      kWhiteColor: Color.lerp(kWhiteColor, other.kWhiteColor, t)!,
      kBlackColor: Color.lerp(kBlackColor, other.kBlackColor, t)!,
      kPrimaryColor: Color.lerp(kPrimaryColor, other.kPrimaryColor, t)!,
      kPrimaryDarkColor:
          Color.lerp(kPrimaryDarkColor, other.kPrimaryDarkColor, t)!,
      kPrimaryLightColor:
          Color.lerp(kPrimaryLightColor, other.kPrimaryLightColor, t)!,
      kBackGroundColor:
          Color.lerp(kBackGroundColor, other.kBackGroundColor, t)!,
      kSurfaceColor: Color.lerp(kSurfaceColor, other.kSurfaceColor, t)!,
      kAccentColor: Color.lerp(kAccentColor, other.kAccentColor, t)!,
      kAccentTextColor:
          Color.lerp(kAccentTextColor, other.kAccentTextColor, t)!,
      kSuccessColor: Color.lerp(kSuccessColor, other.kSuccessColor, t)!,
      kSuccessTextColor:
          Color.lerp(kSuccessTextColor, other.kSuccessTextColor, t)!,
      kSuccessBGColor: Color.lerp(kSuccessBGColor, other.kSuccessBGColor, t)!,
      kWarningColor: Color.lerp(kWarningColor, other.kWarningColor, t)!,
      kWarningTextColor:
          Color.lerp(kWarningTextColor, other.kWarningTextColor, t)!,
      kWarningBGColor: Color.lerp(kWarningBGColor, other.kWarningBGColor, t)!,
      kErrorColor: Color.lerp(kErrorColor, other.kErrorColor, t)!,
      kInfoColor: Color.lerp(kInfoColor, other.kInfoColor, t)!,
      kInfoTextColor: Color.lerp(kInfoTextColor, other.kInfoTextColor, t)!,
      kInfoBGColor: Color.lerp(kInfoBGColor, other.kInfoBGColor, t)!,
      kTextColor: Color.lerp(kTextColor, other.kTextColor, t)!,
      kTextMutedColor: Color.lerp(kTextMutedColor, other.kTextMutedColor, t)!,
      kHintColor: Color.lerp(kHintColor, other.kHintColor, t)!,
      kDisabledButtonColor: Color.lerp(
        kDisabledButtonColor,
        other.kDisabledButtonColor,
        t,
      )!,
      kCountryCodeBGColor: Color.lerp(
        kCountryCodeBGColor,
        other.kCountryCodeBGColor,
        t,
      )!,
      kBorderRoundColor: Color.lerp(
        kBorderRoundColor,
        other.kBorderRoundColor,
        t,
      )!,
    );
  }
}

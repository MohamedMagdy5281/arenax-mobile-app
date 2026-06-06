import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';

abstract class Styles {
  // Helper to get colors safely
  static AppColors _colors(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  // ---------------- TEXT STYLES ----------------

  static TextStyle textStyle12(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 12.spMin,
      fontWeight: FontWeight.w400,
      color: colors.kTextMutedColor,
    );
  }

  static TextStyle textStyle14(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 14.spMin,
      fontWeight: FontWeight.w400,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle16(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 16.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle18(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 18.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle20(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 20.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle22(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 22.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle24(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 24.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  static TextStyle textStyle32(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 32.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kTextColor,
    );
  }

  // ---------------- SPECIAL STYLES ----------------

  static TextStyle subtitle(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 12.spMin,
      fontWeight: FontWeight.w400,
      color: colors.kTextMutedColor,
    );
  }

  static TextStyle errorText(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 14.spMin,
      fontWeight: FontWeight.w500,
      color: colors.kErrorColor,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    final colors = _colors(context);

    return TextStyle(
      fontSize: 16.spMin,
      fontWeight: FontWeight.w600,
      color: colors.kWhiteColor,
    );
  }
}

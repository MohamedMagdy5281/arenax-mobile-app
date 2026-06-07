import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.light.kBackGroundColor,
  extensions: const <ThemeExtension<dynamic>>[
    AppColors.light,
  ],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dark.kBackGroundColor,
  extensions: const <ThemeExtension<dynamic>>[
    AppColors.dark,
  ],
);

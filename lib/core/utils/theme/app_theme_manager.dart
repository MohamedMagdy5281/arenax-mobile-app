import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';

class AppThemeManager {
  static AppColors _colors = AppColors.light;

  static AppColors get colors => _colors;

  static void setDarkMode(bool isDark) {
    _colors = isDark ? AppColors.dark : AppColors.light;
  }
}

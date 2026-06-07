import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.score,
  });

  final int score;

  int get activeBars {
    if (score <= 1) return 1;
    if (score <= 3) return 2;
    if (score == 4) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    final colors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.green,
    ];

    return Row(
      children: List.generate(
        4,
        (index) => Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: index < activeBars
                  ? colors[index]
                  : themeColors.kDisabledButtonColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

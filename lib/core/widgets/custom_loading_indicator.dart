import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator(
      {super.key, this.width, this.height, this.color, this.strokeWidth});
  final double? width;
  final double? height;
  final Color? color;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 3,
        color: color ?? colors.kPrimaryColor, // Change color
      ),
    );
  }
}

import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBarButton extends StatefulWidget {
  const CustomBottomNavBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    required this.iconContainerColor,
    this.size,
    this.animateFill = false,
    this.animationColor,
    this.isMic,
    required this.label,
    this.labelColor,
    this.warningAlert,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color iconContainerColor;
  final double? size;
  final bool animateFill;
  final Color? animationColor;
  final bool? isMic;
  final String label;
  final Color? labelColor;
  final bool? warningAlert;

  @override
  State<CustomBottomNavBarButton> createState() =>
      _CustomBottomNavBarButtonState();
}

class _CustomBottomNavBarButtonState extends State<CustomBottomNavBarButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return InkWell(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: widget.size ?? 28,
                ),
                if (widget.warningAlert == true)
                  Positioned(
                    top: 0,
                    right: -2,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colors.kWarningColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              widget.label,
              style: Styles.textStyle12(context).copyWith(
                color: widget.labelColor ?? colors.kHintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePageTiles extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool? isFirst;

  const ProfilePageTiles({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
            border: isFirst == true
                ? Border.all(width: 0)
                : Border(
                    top: BorderSide(
                        width: 1, color: colors.kDisabledButtonColor))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    color: colors.kPrimaryDarkColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: colors.kPrimaryColor, size: 20),
              ),
              const SizedBox(width: 12),

              // TEXTS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.kTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    subtitle != null
                        ? Text(
                            subtitle!,
                            style: TextStyle(
                              color: colors.kTextMutedColor,
                              fontSize: 12,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 10,
                color: colors.kTextMutedColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

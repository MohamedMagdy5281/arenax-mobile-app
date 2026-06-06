import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InterestsCard extends StatefulWidget {
  final String id;
  final String name;
  final bool isSelected;
  final String image;
  final VoidCallback onTap;
  const InterestsCard(
      {super.key,
      required this.name,
      required this.isSelected,
      required this.image,
      required this.id,
      required this.onTap});

  @override
  State<InterestsCard> createState() => _InterestsCardState();
}

class _InterestsCardState extends State<InterestsCard> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.kDisabledButtonColor,
              border: Border.all(
                color: widget.isSelected
                    ? colors.kPrimaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.name,
            style: Styles.textStyle14(context),
          ),
        ],
      ),
    );
  }
}

import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
    required this.groupValue,
    this.image,
  });

  final String title;
  final dynamic value;
  final dynamic groupValue;
  final String? image;
  final void Function(dynamic)? onChange;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: colors.kHintColor))),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.image != null
                  ? Image.asset(widget.image!, width: 24)
                  : const SizedBox(),
              widget.image != null
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox(),
              Text(
                widget.title,
                style: Styles.textStyle14(context)
                    .copyWith(color: colors.kTextColor),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              widget.onChange!(widget.value);
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  width: widget.value == widget.groupValue ? 0 : 2,
                  color: widget.value == widget.groupValue
                      ? Colors.transparent
                      : colors.kPrimaryColor,
                ),
                color: widget.value == widget.groupValue
                    ? colors.kPrimaryColor
                    : colors.kBackGroundColor,
                shape: BoxShape.circle,
              ),
              child: widget.value == widget.groupValue
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: colors.kBackGroundColor,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

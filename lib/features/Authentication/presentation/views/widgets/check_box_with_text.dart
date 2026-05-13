import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';

class CheckBoxWithText extends StatelessWidget {
  const CheckBoxWithText({
    super.key,
    required this.text,
    required this.radioValue,
    required this.onChanged,
    this.crossAxisAlignment,
  });

  final String text;
  final bool radioValue;
  final void Function(bool?) onChanged;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                side: WidgetStateBorderSide.resolveWith(
                  (Set<WidgetState> states) {
                    return const BorderSide(
                        color: kDarkBlackColor,
                        width: 1.5); // Always black border
                  },
                ),
                shape: RoundedRectangleBorder(
                  // Custom border radius
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Minimize touch area
                visualDensity: VisualDensity.compact, // Reduce checkbox size
              ),
            ),
            child: Checkbox(
              splashRadius: 18,
              side: const BorderSide(
                color: kDarkBlackColor,
                width: 1.5,
              ),
              activeColor: kWhiteColor,
              checkColor: kDarkBlackColor,
              value: radioValue,
              onChanged: onChanged,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: SizedBox(
            //width: MediaQuery.of(context).size.width,
            child: Text(
              text,
              style: Styles.textStyle14,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCheckboxWithText extends StatefulWidget {
  const CustomCheckboxWithText({
    super.key,
    this.onChanged,
    required this.text,
    this.initialValue,
  });

  final Function(bool?)? onChanged;
  final String text;
  final bool? initialValue;

  @override
  State<CustomCheckboxWithText> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckboxWithText> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.initialValue ?? false;

    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            setState(() => isChecked = !isChecked);
            widget.onChanged?.call(isChecked);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: kDarkBlackColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: isChecked
                ? Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: kDarkBlackColor,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            //width: MediaQuery.of(context).size.width,
            child: Text(
              widget.text,
              style: Styles.textStyle14,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

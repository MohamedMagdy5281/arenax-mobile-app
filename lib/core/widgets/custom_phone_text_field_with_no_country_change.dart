import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';

class CustomPhoneTextFieldWithNoCountryChange extends StatefulWidget {
  const CustomPhoneTextFieldWithNoCountryChange({
    super.key,
    required this.controller,
    required this.title,
    required this.placeholder,
    this.validator,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String title;
  final String placeholder;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  State<CustomPhoneTextFieldWithNoCountryChange> createState() =>
      _CustomPhoneTextFieldWithNoCountryChangeState();
}

class _CustomPhoneTextFieldWithNoCountryChangeState
    extends State<CustomPhoneTextFieldWithNoCountryChange> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validator(String? value, BuildContext context) {
    final text = value ?? "";

    if (text.isEmpty) {
      return AppLocalizations.of(context)!.phoneIsRequired;
    }

    if (text.length != 10) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }

    if (!(text.startsWith("10") ||
        text.startsWith("11") ||
        text.startsWith("12") ||
        text.startsWith("15"))) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Styles.textStyle18(context).copyWith(
            fontWeight: FontWeight.w500,
            color: colors.kTextColor,
          ),
        ),
        const SizedBox(height: 8),
        FormField<String>(
          validator: (value) => _validator(widget.controller.text, context),
          builder: (state) {
            final borderColor = state.hasError
                ? colors.kErrorColor
                : _isFocused
                    ? colors.kPrimaryColor
                    : colors.kDisabledButtonColor;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.kSurfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: colors.kCountryCodeBGColor,
                          border: Border(
                            right: BorderSide(color: borderColor),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AssetsData.egFlag,
                                width: 24, height: 24),
                            const SizedBox(width: 4),
                            Text(
                              "+20",
                              style: Styles.textStyle16(context).copyWith(
                                color: colors.kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          focusNode: _focusNode, // 🔥 IMPORTANT
                          controller: widget.controller,
                          readOnly: widget.readOnly,
                          keyboardType: TextInputType.phone,
                          style: Styles.textStyle16(context).copyWith(
                            color: colors.kTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintText: widget.placeholder,
                            hintStyle: Styles.textStyle14(context)
                                .copyWith(color: colors.kHintColor),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                          onChanged: (value) {
                            state.didChange(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      state.errorText ?? "",
                      style: Styles.textStyle12(context).copyWith(
                        color: colors.kErrorColor,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

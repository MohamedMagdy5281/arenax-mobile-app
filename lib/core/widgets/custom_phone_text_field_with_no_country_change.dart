import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';

class CustomPhoneTextFieldWithNoCountryChange extends StatelessWidget {
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
          title,
          style: Styles.textStyle18(context).copyWith(
            fontWeight: FontWeight.w500,
            color: colors.kTextColor,
          ),
        ),
        const SizedBox(height: 8),
        FormField<String>(
          validator: (value) => _validator(controller.text, context),
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.kSurfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: state.hasError
                          ? colors.kErrorColor
                          : colors.kDisabledButtonColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      // COUNTRY CODE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: colors.kCountryCodeBGColor,
                          border: Border(
                            right: BorderSide(
                              color: colors.kDisabledButtonColor,
                              width: 1,
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AssetsData.egFlag,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "+20",
                              style: Styles.textStyle12(context).copyWith(
                                color: colors.kHintColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // INPUT
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          readOnly: readOnly,
                          keyboardType: TextInputType.phone,
                          style: Styles.textStyle14(context).copyWith(
                            color: colors.kTextColor,
                          ),
                          decoration: InputDecoration(
                            hint: Text(
                              placeholder,
                              style: Styles.textStyle14(context)
                                  .copyWith(color: colors.kHintColor),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
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

                // 🔥 ERROR OUTSIDE FIELD (FIX)
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

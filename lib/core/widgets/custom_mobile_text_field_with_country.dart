import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomMobileTextFieldWithCountry extends StatelessWidget {
  const CustomMobileTextFieldWithCountry(
      {super.key,
      required this.controller,
      required this.countryCode,
      this.onCountryChanged,
      this.currentCountryCode,
      required this.title,
      required this.placeholder,
      this.onChanged,
      this.validator,
      this.readOnly});

  final TextEditingController controller;
  final String countryCode;
  final void Function(Country)? onCountryChanged;
  final String? currentCountryCode;
  final String title;
  final String placeholder;
  final void Function(PhoneNumber)? onChanged;
  final String? Function(String?)? validator;
  final bool? readOnly;

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
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: IntlPhoneField(
                showCountryFlag: false,
                pickerDialogStyle: PickerDialogStyle(
                    searchFieldInputDecoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.searchCountry,
                )),
                readOnly: readOnly ?? false,
                dropdownTextStyle: Styles.textStyle14(context).copyWith(
                  color: colors.kTextColor,
                ),
                dropdownDecoration: BoxDecoration(
                  color: colors.kBackGroundColor,
                  border: Border(
                    right: BorderSide(
                      color: colors.kHintColor,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: colors.kHintColor,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded,
                    size: 24, color: colors.kTextColor),
                textAlign:
                    globals.appLang == 'ar' ? TextAlign.right : TextAlign.left,
                languageCode: globals.appLang,
                disableLengthCheck: false,
                countries: const [
                  Country(
                    name: 'Saudia',
                    flag: '🇸🇦',
                    code: 'SA',
                    dialCode: '966',
                    nameTranslations: {
                      "en": "Saudia Arabia",
                      "ar": "السعودية",
                    },
                    minLength: 9,
                    maxLength: 9,
                  ),
                  Country(
                    name: "Jordan",
                    nameTranslations: {
                      "en": "Jordan",
                      "ar": "الأردن",
                    },
                    flag: "🇯🇴",
                    code: "JO",
                    dialCode: "962",
                    minLength: 9,
                    maxLength: 9,
                  ),
                  Country(
                    name: "Egypt",
                    nameTranslations: {
                      "en": "Egypt",
                      "ar": "مصر",
                    },
                    flag: "🇪🇬",
                    code: "EG",
                    dialCode: "20",
                    minLength: 10,
                    maxLength: 10,
                  ),
                  Country(
                    name: "Palestine",
                    nameTranslations: {
                      "en": "Palestine",
                      "ar": "فلسطين",
                    },
                    flag: "🇵🇸",
                    code: "PS",
                    dialCode: "970",
                    minLength: 9,
                    maxLength: 9,
                  ),
                  Country(
                    name: "Qatar",
                    nameTranslations: {
                      "en": "Qatar",
                      "ar": "قطر",
                    },
                    flag: "🇶🇦",
                    code: "QA",
                    dialCode: "974",
                    minLength: 8,
                    maxLength: 8,
                  ),
                  Country(
                    name: "Morocco",
                    nameTranslations: {
                      "en": "Morocco",
                      "ar": "المغرب",
                    },
                    flag: "🇲🇦",
                    code: "MA",
                    dialCode: "212",
                    minLength: 9,
                    maxLength: 9,
                  ),
                  Country(
                    name: "United Arab Emirates",
                    nameTranslations: {
                      "en": "United Arab Emirates",
                      "ar": "الإمارات العربية المتحدة",
                    },
                    flag: "🇦🇪",
                    code: "AE",
                    dialCode: "971",
                    minLength: 9,
                    maxLength: 9,
                  ),
                ],
                controller: controller,
                invalidNumberMessage:
                    AppLocalizations.of(context)!.mobileValidateMsg,
                decoration: InputDecoration(
                  fillColor: colors.kSurfaceColor,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: placeholder,
                  hintStyle: Styles.textStyle14(context).copyWith(
                    color: colors.kHintColor,
                    fontWeight: FontWeight.w400,
                  ),
                  hintTextDirection: TextDirection.ltr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: colors.kHintColor, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: colors.kHintColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: colors.kHintColor, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: colors.kErrorColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: colors.kErrorColor, width: 1),
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                  errorText: state.errorText,
                ),
                // flagsButtonMargin: EdgeInsets.only(left: 8),
                flagsButtonPadding:
                    const EdgeInsets.only(left: 1, right: 8, top: 8, bottom: 8),
                initialCountryCode: countryCode,
                onChanged: onChanged,
                autovalidateMode: AutovalidateMode.disabled,
                onCountryChanged: onCountryChanged,
              ),
            );
          },
          validator: (value) {
            if (controller.text == "") {
              return AppLocalizations.of(context)!.phoneIsRequired;
            }
            if (currentCountryCode == "EG") {
              if (controller.text.length == 10) {
                if (!(controller.text.startsWith("10") ||
                    controller.text.startsWith("11") ||
                    controller.text.startsWith("12") ||
                    controller.text.startsWith("15"))) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "SA") {
              if (controller.text.length == 9) {
                if (controller.text.startsWith("51") ||
                    controller.text.startsWith("52") ||
                    !controller.text.startsWith("5")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "JO") {
              if (controller.text.length == 9) {
                if (!controller.text.startsWith("75") &&
                    !controller.text.startsWith("77") &&
                    !controller.text.startsWith("78") &&
                    !controller.text.startsWith("79")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "PS") {
              if (controller.text.length == 9) {
                if (!controller.text.startsWith("59") &&
                    !controller.text.startsWith("56")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "QA") {
              if (controller.text.length == 8) {
                if (!controller.text.startsWith("33") &&
                    !controller.text.startsWith("55") &&
                    !controller.text.startsWith("70") &&
                    !controller.text.startsWith("77") &&
                    !controller.text.startsWith("50") &&
                    !controller.text.startsWith("66")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "MA") {
              if (controller.text.length == 9) {
                if (!controller.text.startsWith("6") &&
                    !controller.text.startsWith("7")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            } else if (currentCountryCode == "AE") {
              if (controller.text.length == 9) {
                if (!controller.text.startsWith("50") &&
                    !controller.text.startsWith("52") &&
                    !controller.text.startsWith("54") &&
                    !controller.text.startsWith("55") &&
                    !controller.text.startsWith("56") &&
                    !controller.text.startsWith("57") &&
                    !controller.text.startsWith("58")) {
                  return AppLocalizations.of(context)!.invalidPhoneNumber;
                }
              } else {
                return AppLocalizations.of(context)!.invalidPhoneNumber;
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}

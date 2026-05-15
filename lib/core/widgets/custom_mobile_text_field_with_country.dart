import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Stack(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kLightBlueColor.withOpacity(.3),
                spreadRadius: 0,
                blurRadius: 12,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: IntlPhoneField(
                pickerDialogStyle: PickerDialogStyle(
                    searchFieldInputDecoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.searchCountry,
                )),
                readOnly: readOnly ?? false,
                dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded,
                    size: 24, color: kinfoColor),
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
                    maxLength: 10,
                  ),
                ],
                controller: controller,
                invalidNumberMessage:
                    AppLocalizations.of(context)!.mobileValidateMsg,
                decoration: InputDecoration(
                  label: Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: kSideBG,
                    ),
                    child: Text(
                      title,
                      style: Styles.textStyle18,
                    ),
                  ),
                  fillColor: kWhiteColor,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: placeholder,
                  hintStyle: Styles.textStyle14.copyWith(
                    color: kHintColor,
                    fontWeight: FontWeight.w400,
                  ),
                  hintTextDirection: TextDirection.ltr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kBorderColor, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kBorderColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kBorderColor, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kErrorColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kErrorColor, width: 1),
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                  errorText: state.errorText,
                ),
                initialCountryCode: countryCode,
                onChanged: onChanged,
                autovalidateMode: AutovalidateMode.disabled,
                onCountryChanged: onCountryChanged,
              ),
            );
          },
          validator: validator ??
              (value) {
                if (controller.text == "") {
                  return AppLocalizations.of(context)!.cantBeEmpty;
                }
                if (currentCountryCode == "SA") {
                  if (controller.text.length == 10) {
                    if (!(controller.text.startsWith("051") ||
                        controller.text.startsWith("052") ||
                        controller.text.startsWith("05"))) {
                      return AppLocalizations.of(context)!.mobileValidateMsg;
                    }
                  } else if (controller.text.length == 9) {
                    if (!(controller.text.startsWith("51") ||
                        controller.text.startsWith("52") ||
                        controller.text.startsWith("5"))) {
                      return AppLocalizations.of(context)!.mobileValidateMsg;
                    }
                  } else {
                    return AppLocalizations.of(context)!.mobileValidateMsg;
                  }
                }
                return null;
              },
        ),
      ],
    );
  }
}

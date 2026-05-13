import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final IconData? icon;
  final Widget? previousIcon;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? isLoading;
  final String? loadingText;
  final bool? isDisabled;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final Color? disabledButtonColor;
  final TextStyle? textStyle;
  final String? image;

  const CustomButton({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
    this.icon,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.isLoading,
    this.loadingText,
    this.isDisabled,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.disabledButtonColor,
    this.textStyle,
    this.previousIcon,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 56,
      child: Material(
        color: isDisabled != null && isDisabled == true
            ? disabledButtonColor ?? kDisableButtonColor
            : backgroundColor ?? kPrimaryColor,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: isDisabled != null && isDisabled == true ? null : itemCallBack,
          borderRadius: BorderRadius.circular(16.0),
          splashFactory: InkRipple.splashFactory,
          child: Container(
            width: width,
            height: height ?? 56,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: isDisabled != null && isDisabled == true
                      ? disabledBorderColor ?? Colors.transparent
                      : borderColor ?? kPrimaryColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: isLoading == true
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loadingText ?? '',
                        style: Styles.textStyle16.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const CustomLoadingIndicator(
                        color: kWhiteColor,
                        height: 20,
                        width: 20,
                      )
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon != null
                          ? Row(
                              children: [
                                Text(
                                  text,
                                  style: textStyle ??
                                      Styles.textStyle16.copyWith(
                                        color: isDisabled != null &&
                                                isDisabled == true
                                            ? disabledTextColor ?? kWhiteColor
                                            : textColor ?? kWhiteColor,
                                      ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  icon,
                                  color: iconColor ?? kWhiteColor,
                                ),
                              ],
                            )
                          : image != null
                              ? Row(
                                  children: [
                                    Text(
                                      text,
                                      style: textStyle ??
                                          Styles.textStyle16.copyWith(
                                            color: isDisabled != null &&
                                                    isDisabled == true
                                                ? disabledTextColor ??
                                                    kWhiteColor
                                                : textColor ?? kWhiteColor,
                                          ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      image!,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ],
                                )
                              : previousIcon != null
                                  ? Row(
                                      children: [
                                        previousIcon!,
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          text,
                                          style: textStyle ??
                                              Styles.textStyle16.copyWith(
                                                color: isDisabled != null &&
                                                        isDisabled == true
                                                    ? disabledTextColor ??
                                                        kWhiteColor
                                                    : textColor ?? kWhiteColor,
                                              ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    )
                                  : Flexible(
                                      child: Text(
                                        text,
                                        style: textStyle ??
                                            Styles.textStyle16.copyWith(
                                              color: isDisabled != null &&
                                                      isDisabled == true
                                                  ? disabledTextColor ??
                                                      kWhiteColor
                                                  : textColor ?? kWhiteColor,
                                            ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithOptionalIconAndSuffix extends StatelessWidget {
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final String? text;
  final String? icon;
  final IconData? optionalIcon;
  final IconData? suffixIcon;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final double? iconSize;

  const CustomButtonWithOptionalIconAndSuffix({
    super.key,
    required this.itemCallBack,
    this.height,
    this.width,
    this.text,
    this.icon,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.optionalIcon,
    this.backgroundColor,
    this.suffixIcon,
    this.labelStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 66,
      decoration: BoxDecoration(
          color: backgroundColor ?? kButtonBg,
          border: Border.all(
              width: 1,
              color: borderColor ?? Colors.transparent,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(28)),
      child: ElevatedButton(
        onPressed: itemCallBack,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? kButtonBg),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        child: optionalIcon != null || suffixIcon != null
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (icon != null)
                        SvgPicture.asset(
                          icon!,
                        )
                      else
                        Icon(
                          optionalIcon ?? Iconsax.send_2,
                          size: iconSize ?? 28,
                          color: iconColor ?? kWhiteColor,
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        text ?? AppLocalizations.of(context)!.signIn,
                        style: labelStyle ??
                            Styles.textStyle22.copyWith(
                              fontWeight: FontWeight.w600,
                              color: textColor ?? kWhiteColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  suffixIcon != null
                      ? Icon(
                          suffixIcon ?? Iconsax.send_2,
                          size: 28,
                          color: iconColor ?? kWhiteColor,
                        )
                      : SizedBox(),
                ],
              )
            : Center(
                child: Text(
                  text ?? AppLocalizations.of(context)!.signIn,
                  style: labelStyle ??
                      Styles.textStyle22.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor ?? kWhiteColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}

class CustomRoundedButtonWithOptionalIcon extends StatelessWidget {
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final String? text;
  final String? icon;
  final IconData? optionalIcon;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;

  const CustomRoundedButtonWithOptionalIcon({
    super.key,
    required this.itemCallBack,
    this.height,
    this.width,
    this.text,
    this.icon,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.optionalIcon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 56,
      decoration: BoxDecoration(
          color: backgroundColor ?? kPrimaryColor,
          border: Border.all(
              width: 1,
              color: borderColor ?? kPrimaryColor,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(28)),
      child: ElevatedButton(
        onPressed: itemCallBack,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? kWhiteColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? AppLocalizations.of(context)!.signIn,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor ?? kWhiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 8,
            ),
            if (optionalIcon != null)
              Icon(
                optionalIcon ?? Iconsax.send_2,
                size: 28,
                color: iconColor ?? kWhiteColor,
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CustomButtonWithArrow extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final bool? isDisabled;
  final bool? arrowWithBackground;

  const CustomButtonWithArrow({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
    this.isDisabled,
    this.arrowWithBackground,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SizedBox(
      width: width,
      height: height ?? 56,
      child: Material(
        color: isDisabled != null && isDisabled == true
            ? kDisableButtonColor
            : kPrimaryColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: isDisabled != null && isDisabled == true ? null : itemCallBack,
          borderRadius: BorderRadius.circular(12.0),
          splashFactory: InkRipple.splashFactory,
          child: SizedBox(
            width: width,
            height: height ?? 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Styles.textStyle16.copyWith(
                    color: kWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 12,
                ),
                arrowWithBackground != null && arrowWithBackground == true
                    ? isArabic
                        ? Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                                color: kWhiteColor, shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: const Icon(
                              Iconsax.arrow_left4,
                              color: kPrimaryColor,
                              size: 14,
                            ),
                          )
                        : Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                                color: kWhiteColor, shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: const Icon(
                              Iconsax.arrow_right_14,
                              color: kPrimaryColor,
                              size: 14,
                            ),
                          )
                    : isArabic
                        ? const Icon(
                            Iconsax.arrow_left4,
                            color: kWhiteColor,
                          )
                        : const Icon(
                            Iconsax.arrow_right_14,
                            color: kWhiteColor,
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithShadow extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? isLoading;
  final String? loadingText;
  final bool? isDisabled;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final Color? disabledButtonColor;
  final TextStyle? textStyle;

  const CustomButtonWithShadow({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
    this.icon,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.isLoading,
    this.loadingText,
    this.isDisabled,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.disabledButtonColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SizedBox(
        width: width,
        height: height ?? 56,
        child: Material(
          color: isDisabled != null && isDisabled == true
              ? disabledButtonColor ?? kDisableButtonColor
              : backgroundColor ?? kPrimaryColor,
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            onTap:
                isDisabled != null && isDisabled == true ? null : itemCallBack,
            borderRadius: BorderRadius.circular(16.0),
            splashFactory: InkRipple.splashFactory,
            child: Container(
              width: width,
              height: height ?? 56,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: isDisabled != null && isDisabled == true
                        ? disabledBorderColor ?? Colors.transparent
                        : borderColor ?? kPrimaryColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: isLoading == true
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loadingText ?? '',
                          style: Styles.textStyle16.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const CustomLoadingIndicator(
                          color: kWhiteColor,
                          height: 20,
                          width: 20,
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Row(
                                children: [
                                  Text(
                                    text,
                                    style: textStyle ??
                                        Styles.textStyle16.copyWith(
                                          color: isDisabled != null &&
                                                  isDisabled == true
                                              ? disabledTextColor ?? kWhiteColor
                                              : textColor ?? kWhiteColor,
                                        ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    icon,
                                    color: iconColor ?? kWhiteColor,
                                  ),
                                ],
                              )
                            : Flexible(
                                child: Text(
                                  text,
                                  style: textStyle ??
                                      Styles.textStyle16.copyWith(
                                        color: isDisabled != null &&
                                                isDisabled == true
                                            ? disabledTextColor ?? kWhiteColor
                                            : textColor ?? kWhiteColor,
                                      ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSelectedButton extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final bool? isLoading;
  final String? loadingText;
  final bool? isDisabled;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final Color? disabledButtonColor;
  final TextStyle? textStyle;
  final bool isSelected;
  final Widget? unselectedLeading;
  final Widget? selectedLeading;

  const CustomSelectedButton({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
    this.isLoading,
    this.loadingText,
    this.isDisabled,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.disabledButtonColor,
    this.textStyle,
    required this.isSelected,
    this.unselectedLeading,
    this.selectedLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SizedBox(
        width: width,
        height: height ?? 56,
        child: Material(
          color: isDisabled != null && isDisabled == true
              ? disabledButtonColor ?? kDisableButtonColor
              : isSelected
                  ? kBorderColor
                  : kWhiteColor,
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            onTap:
                isDisabled != null && isDisabled == true ? null : itemCallBack,
            borderRadius: BorderRadius.circular(16.0),
            splashFactory: InkRipple.splashFactory,
            child: Container(
              width: width,
              height: height ?? 56,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: isDisabled != null && isDisabled == true
                      ? disabledBorderColor ?? Colors.transparent
                      : isSelected
                          ? kBorderColor
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: isLoading == true
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loadingText ?? '',
                          style: Styles.textStyle16.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const CustomLoadingIndicator(
                          color: kWhiteColor,
                          height: 20,
                          width: 20,
                        )
                      ],
                    )
                  : unselectedLeading != null && selectedLeading != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              isSelected
                                  ? selectedLeading!
                                  : unselectedLeading!,
                              const SizedBox(width: 8),
                              Text(
                                text,
                                style: textStyle ??
                                    Styles.textStyle16.copyWith(
                                      color: isDisabled != null &&
                                              isDisabled == true
                                          ? disabledTextColor ?? kWhiteColor
                                          : isSelected
                                              ? kWhiteColor
                                              : kDarkBlackColor,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                text,
                                style: textStyle ??
                                    Styles.textStyle16.copyWith(
                                      color: isDisabled != null &&
                                              isDisabled == true
                                          ? disabledTextColor ?? kWhiteColor
                                          : isSelected
                                              ? kWhiteColor
                                              : kDarkBlackColor,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

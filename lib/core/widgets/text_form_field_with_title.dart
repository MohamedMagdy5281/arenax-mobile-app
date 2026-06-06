import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class TextFormFieldWithTitle extends StatefulWidget {
  final double? width;
  final double? height;
  final String title;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? enabled;
  final int? maxLength;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? isOptional;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixWidget;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final TextStyle? titleStyle;
  final bool? readOnly;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final bool? disabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? optionalLabelButton;
  final VoidCallback? optionalLabelButtonOnTap;

  const TextFormFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.autoFocus,
    this.inputType,
    this.enabled,
    this.maxLength,
    required this.validator,
    this.onTap,
    this.placeholder,
    this.isOptional,
    this.suffix,
    this.obscureText,
    this.onChanged,
    this.titleStyle,
    this.readOnly,
    this.focusNode,
    this.minLines,
    this.maxLines,
    this.width,
    this.height,
    this.prefix,
    this.disabled,
    this.prefixWidget,
    this.inputFormatters,
    this.optionalLabelButton,
    this.optionalLabelButtonOnTap,
  });

  @override
  TextFormFieldWithTitleState createState() => TextFormFieldWithTitleState();
}

class TextFormFieldWithTitleState extends State<TextFormFieldWithTitle> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _controller.addListener(() => setState(() {}));

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
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
        // TITLE
        widget.optionalLabelButton != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: (widget.titleStyle ??
                            Styles.textStyle18(context).copyWith(
                              fontWeight: FontWeight.w500,
                            ))
                        .copyWith(color: colors.kTextColor),
                  ),
                  GestureDetector(
                    onTap: widget.optionalLabelButtonOnTap,
                    child: widget.optionalLabelButton,
                  )
                ],
              )
            : Text(
                widget.title,
                style: (widget.titleStyle ??
                        Styles.textStyle18(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ))
                    .copyWith(color: colors.kTextColor),
              ),

        const SizedBox(height: 8),

        FormField<String>(
          validator: widget.validator,
          initialValue: _controller.text,
          builder: (state) {
            final borderColor = state.hasError
                ? colors.kErrorColor
                : isFocused
                    ? colors.kPrimaryColor
                    : colors.kDisabledButtonColor;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: widget.height ?? 55,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: colors.kSurfaceColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: widget.inputType,
                    autofocus: widget.autoFocus ?? false,
                    enabled: widget.enabled ?? true,
                    readOnly: widget.readOnly ?? false,
                    maxLength: widget.maxLength,
                    obscureText: widget.obscureText ?? false,
                    inputFormatters: widget.inputFormatters,
                    onTap: () {
                      if (widget.disabled == true) {
                        _focusNode.unfocus();
                        return;
                      }
                      widget.onTap?.call();
                    },
                    onChanged: (value) {
                      state.didChange(value);

                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      } else {
                        final converted =
                            globals.convertArabicNumbersToEnglish(value);

                        if (value != converted) {
                          final cursor = _controller.selection;

                          _controller.value = TextEditingValue(
                            text: converted,
                            selection: cursor,
                          );
                        }
                      }
                    },
                    style: Styles.textStyle16(context).copyWith(
                      color: colors.kTextColor,
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

                      prefixIcon: widget.prefix,
                      prefix: widget.prefixWidget,

                      // ✅ FIXED SHOW/HIDE SUPPORT
                      suffixIcon: widget.suffix != null
                          ? SizedBox(
                              width: 70,
                              child: Center(child: widget.suffix),
                            )
                          : null,

                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

                // ERROR TEXT
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 8),
                    child: Text(
                      state.errorText ?? "",
                      style: TextStyle(
                        color: colors.kErrorColor,
                        fontSize: 12,
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

// class TextFormFieldWithNoTitle extends StatefulWidget {
//   const TextFormFieldWithNoTitle(
//       {super.key,
//       this.width,
//       this.height,
//       this.placeholder,
//       this.controller,
//       this.inputType,
//       this.enabled,
//       this.maxLength,
//       this.autoFocus,
//       this.validator,
//       this.onTap,
//       this.isOptional,
//       this.suffix,
//       this.prefix,
//       this.prefixWidget,
//       this.obscureText,
//       this.onChanged,
//       this.titleStyle,
//       this.readOnly,
//       this.focusNode,
//       this.minLines,
//       this.maxLines,
//       this.disabled,
//       this.inputFormatters});

//   final double? width;
//   final double? height;
//   final String? placeholder;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final bool? enabled;
//   final int? maxLength;
//   final bool? autoFocus;
//   final String? Function(String?)? validator;
//   final void Function()? onTap;
//   final bool? isOptional;
//   final Widget? suffix;
//   final Widget? prefix;
//   final Widget? prefixWidget;
//   final bool? obscureText;
//   final void Function(String)? onChanged;
//   final TextStyle? titleStyle;
//   final bool? readOnly;
//   final FocusNode? focusNode;
//   final int? minLines;
//   final int? maxLines;
//   final bool? disabled;
//   final List<TextInputFormatter>? inputFormatters;
//   @override
//   State<TextFormFieldWithNoTitle> createState() =>
//       _TextFormFieldWithNoTitleState();
// }

// class _TextFormFieldWithNoTitleState extends State<TextFormFieldWithNoTitle> {
//   late TextEditingController _controller;
//   late FocusNode _focusNode;
//   bool isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? TextEditingController();
//     _focusNode = widget.focusNode ?? FocusNode();
//     _controller.addListener(_onTextChanged);
//   }

//   void _onTextChanged() {
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_onTextChanged);
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     if (widget.focusNode == null) {
//       _focusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         TextFormField(
//           controller: _controller,
//           inputFormatters: widget.inputFormatters,
//           enabled: widget.enabled ?? true,
//           maxLength: widget.maxLength,
//           keyboardType: widget.inputType,
//           autofocus: widget.autoFocus ?? false,
//           validator: widget.validator,
//           onChanged: widget.onChanged
//           //  ??
//           //     (String? text) {
//           //       final converted = globals.convertArabicNumbersToEnglish(text!);
//           //       if (text != converted) {
//           //         final cursorPosition = widget.controller?.selection;
//           //         widget.controller?.value = TextEditingValue(
//           //           text: converted,
//           //           selection: cursorPosition!,
//           //         );
//           //       }
//           //     }
//           ,
//           obscureText: widget.obscureText ?? false,
//           focusNode: _focusNode,
//           decoration: InputDecoration(
//             suffixIcon: widget.suffix != null
//                 ? GestureDetector(
//                     onTap: () {
//                       if (widget.disabled == true) {
//                         _focusNode.requestFocus(); // Focus the field
//                       }
//                     },
//                     child: widget.suffix,
//                   )
//                 : null,
//             prefix: widget.prefixWidget,
//             prefixIcon: widget.prefix,
//             fillColor: kWhiteColor,
//             filled: true,
//             hintText: widget.placeholder,
//             hintStyle: Styles.textStyle14(context).copyWith(
//               color: kGrey3Color,
//               fontWeight: FontWeight.w400,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: kPrimaryColor, width: 1),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: kGrey3Color, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: kGrey3Color, width: 1),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: kGreyBGColor, width: 1),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: kErrorColor, width: 1),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: kErrorColor, width: 1),
//             ),
//             contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
//           ),
//         ),
//       ],
//     );
//   }
// }
}

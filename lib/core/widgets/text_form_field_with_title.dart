import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class TextFormFieldWithFloatingTitle extends StatefulWidget {
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

  const TextFormFieldWithFloatingTitle({
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
  });

  @override
  TextFormFieldWithFloatingTitleState createState() =>
      TextFormFieldWithFloatingTitleState();
}

class TextFormFieldWithFloatingTitleState
    extends State<TextFormFieldWithFloatingTitle> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
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
        FocusScope(
          child: Focus(
            onFocusChange: (focused) {
              setState(() => isFocused = focused);
            },
            child: GestureDetector(
              onTap: () {
                // Double tap: Focus the field
                if (widget.disabled == true) {
                  _focusNode.unfocus();
                }
              },
              onDoubleTap: () {
                // Double tap: Focus the field
                if (widget.disabled == true) {
                  _focusNode.unfocus();
                }
              },
              child: TextFormField(
                onTap: () {
                  if (widget.disabled == true) {
                    _focusNode.unfocus();
                    return;
                  }
                  widget.onTap?.call();
                },
                controller: _controller,
                inputFormatters: widget.inputFormatters,
                enabled: widget.enabled ?? true,
                maxLength: widget.maxLength,
                keyboardType: widget.inputType,
                autofocus: widget.autoFocus ?? false,
                validator: widget.validator,
                onChanged: widget.onChanged ??
                    (String? text) {
                      final converted =
                          globals.convertArabicNumbersToEnglish(text!);
                      if (text != converted) {
                        final cursorPosition = widget.controller?.selection;
                        widget.controller?.value = TextEditingValue(
                          text: converted,
                          selection: cursorPosition!,
                        );
                      }
                    },
                obscureText: widget.obscureText ?? false,
                focusNode: _focusNode,
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
                      widget.title,
                      style: Styles.textStyle18,
                    ),
                  ),
                  suffixIcon: widget.suffix != null
                      ? GestureDetector(
                          onTap: () {
                            if (widget.disabled == true) {
                              _focusNode.requestFocus(); // Focus the field
                            }
                          },
                          child: widget.suffix,
                        )
                      : null,
                  prefix: widget.prefixWidget,
                  prefixIcon: widget.prefix,
                  fillColor: kWhiteColor,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.placeholder,
                  hintStyle: Styles.textStyle14.copyWith(
                    color: kHintColor,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kBorderColor, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: kNonFocusedField, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kBorderColor, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kSideBG, width: 1),
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFormFieldWithNoTitle extends StatefulWidget {
  const TextFormFieldWithNoTitle(
      {super.key,
      this.width,
      this.height,
      this.placeholder,
      this.controller,
      this.inputType,
      this.enabled,
      this.maxLength,
      this.autoFocus,
      this.validator,
      this.onTap,
      this.isOptional,
      this.suffix,
      this.prefix,
      this.prefixWidget,
      this.obscureText,
      this.onChanged,
      this.titleStyle,
      this.readOnly,
      this.focusNode,
      this.minLines,
      this.maxLines,
      this.disabled,
      this.inputFormatters});

  final double? width;
  final double? height;
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
  @override
  State<TextFormFieldWithNoTitle> createState() =>
      _TextFormFieldWithNoTitleState();
}

class _TextFormFieldWithNoTitleState extends State<TextFormFieldWithNoTitle> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
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
    return Stack(
      children: [
        TextFormField(
          controller: _controller,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled ?? true,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          autofocus: widget.autoFocus ?? false,
          validator: widget.validator,
          onChanged: widget.onChanged
          //  ??
          //     (String? text) {
          //       final converted = globals.convertArabicNumbersToEnglish(text!);
          //       if (text != converted) {
          //         final cursorPosition = widget.controller?.selection;
          //         widget.controller?.value = TextEditingValue(
          //           text: converted,
          //           selection: cursorPosition!,
          //         );
          //       }
          //     }
          ,
          obscureText: widget.obscureText ?? false,
          focusNode: _focusNode,
          decoration: InputDecoration(
            suffixIcon: widget.suffix != null
                ? GestureDetector(
                    onTap: () {
                      if (widget.disabled == true) {
                        _focusNode.requestFocus(); // Focus the field
                      }
                    },
                    child: widget.suffix,
                  )
                : null,
            prefix: widget.prefixWidget,
            prefixIcon: widget.prefix,
            fillColor: kWhiteColor,
            filled: true,
            hintText: widget.placeholder,
            hintStyle: Styles.textStyle14.copyWith(
              color: kGrey3Color,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kPrimaryColor, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGrey3Color, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGrey3Color, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGreyBGColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kErrorColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kErrorColor, width: 1),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
          ),
        ),
      ],
    );
  }
}

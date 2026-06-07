import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';

class DateTimePickerTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String placeholder;
  final String title;
  final TextStyle? titleStyle;
  final String? Function(String?)? validator;
  final bool? disabled;
  final Widget? suffix;
  final Widget? prefix;
  final FocusNode? focusNode;

  const DateTimePickerTextField({
    super.key,
    required this.placeholder,
    required this.title,
    this.titleStyle,
    this.validator,
    this.controller,
    this.disabled,
    this.suffix,
    this.prefix,
    this.focusNode,
  });

  @override
  State<DateTimePickerTextField> createState() =>
      _DateTimePickerTextFieldState();
}

class _DateTimePickerTextFieldState extends State<DateTimePickerTextField> {
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

  Future<void> _pickDateTime(BuildContext context) async {
    if (widget.disabled == true) return;

    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (selectedDate == null) return;

    try {
      final String formattedDate = DateFormat('d-M-yyyy').format(selectedDate);

      setState(() {
        _controller.text = formattedDate;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error formatting date: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return Stack(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.disabled == true) {
              _focusNode.unfocus();
            }
          },
          onDoubleTap: () {
            if (widget.disabled == true) {
              _focusNode.unfocus();
            }
          },
          child: TextFormField(
            controller: _controller,
            readOnly: true,
            focusNode: _focusNode,
            onTap: () => _pickDateTime(context),
            validator: widget.validator ??
                (data) {
                  if (data == null || data.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeEmpty;
                  }
                  return null;
                },
            decoration: InputDecoration(
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.kSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.title,
                  style: widget.titleStyle ?? Styles.textStyle18(context),
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.placeholder,
              hintStyle: Styles.textStyle14(context).copyWith(
                color: colors.kHintColor,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: colors.kWhiteColor,
              suffixIcon: widget.suffix != null
                  ? GestureDetector(
                      onTap: () => _pickDateTime(context),
                      child: widget.suffix,
                    )
                  : null,
              prefixIcon: widget.prefix,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: colors.kDisabledButtonColor, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: colors.kDisabledButtonColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: colors.kDisabledButtonColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colors.kErrorColor, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: colors.kErrorColor, width: 1),
              ),
              contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';// import 'package:iconsax/iconsax.dart';
// import 'package:arenax_mobile_app/client/api.dart';
// import 'package:arenax_mobile_app/core/utils/colors.dart';
// import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
// import 'package:arenax_mobile_app/core/utils/styles.dart';

// class LanguageAutoCompleteDropDown extends StatefulWidget {
//   final List<GetAllLanguageResponse>? options;
//   final int? selectedValue;
//   final Function(int) onChanged;
//   final Function(String)? textFieldOnChanged;
//   final String title;
//   final TextEditingController controller;
//   final int? selectedIndex;
//   final void Function(GetAllLanguageResponse)? onSelected;
//   final FocusNode focusNode;
//   final bool showOptions;
//   final Function(bool) setShowOptions;
//   final Function() clearField;
//   final void Function() toggleList;
//   final void Function() onTap;
//   final String? Function(String?)? validator;
//   final String? hintText;
//   final TextStyle? titleStyle;

//   const LanguageAutoCompleteDropDown({
//     super.key,
//     required this.options,
//     this.selectedValue,
//     required this.onChanged,
//     required this.title,
//     required this.controller,
//     required this.selectedIndex,
//     this.onSelected,
//     required this.focusNode,
//     required this.showOptions,
//     required this.toggleList,
//     required this.setShowOptions,
//     required this.onTap,
//     this.validator,
//     this.textFieldOnChanged,
//     required this.clearField,
//     this.hintText,
//     this.titleStyle,
//     // required this.theController,
//   });

//   @override
//   LanguageAutoCompleteDropDownState createState() =>
//       LanguageAutoCompleteDropDownState();
// }

// class LanguageAutoCompleteDropDownState
//     extends State<LanguageAutoCompleteDropDown> {
//   bool isFocused = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 55,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: kLightBlueColor.withOpacity(.3),
//                 spreadRadius: 0,
//                 blurRadius: 12,
//                 offset: Offset(2, 2),
//               ),
//             ],
//           ),
//         ),
//         FocusScope(
//           child: Focus(
//             onFocusChange: (focused) {
//               setState(() => isFocused = focused);
//             },
//             child: TypeAheadField<GetAllLanguageResponse>(
//               controller: widget.controller,
//               builder: (context, controller, focusNode) {
//                 return TextFormField(
//                   onTap: () {
//                     if (focusNode.hasFocus) {
//                       focusNode.unfocus(); // Lose focus if already focused
//                     } else {
//                       focusNode.requestFocus(); // Otherwise, request focus
//                     }
//                   },
//                   onChanged: widget.textFieldOnChanged,
//                   validator: widget.validator,
//                   controller: controller,
//                   focusNode: focusNode,
//                   autofocus: false,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                     label: Container(
//                       margin: EdgeInsets.all(0),
//                       padding: EdgeInsets.all(8),
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         color: kSideBG,
//                       ),
//                       child: Text(
//                         widget.title,
//                         style: Styles.textStyle18(context),
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: kWhiteColor,
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     suffixIcon: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (controller.text.isNotEmpty) ...[
//                           GestureDetector(
//                             onTap: () {
//                               widget.clearField();
//                               focusNode.unfocus(); // Clear the field
//                               setState(() {});
//                             },
//                             child: const Icon(
//                               Iconsax.close_square,
//                               size: 24,
//                             ),
//                           ),
//                           const SizedBox(width: 8), // Add space between icons
//                         ],
//                         Icon(
//                           color: kDefaultIconDarkColor,
//                           focusNode.hasFocus
//                               ? Iconsax.arrow_up_24
//                               : Iconsax.arrow_down_14,
//                           size: 24,
//                         ),
//                         if (controller.text.isNotEmpty) ...[
//                           const SizedBox(width: 12), // Add space between icons
//                         ],
//                       ],
//                     ),
//                     prefixIcon: Icon(Iconsax.language_circle),
//                     hintText: widget.hintText ??
//                         AppLocalizations.of(context)!.searchYourLang,
//                     hintStyle: Styles.textStyle14(context).copyWith(
//                       color: kHintColor,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           const BorderSide(color: kBorderColor, width: 1),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           const BorderSide(color: kBorderColor, width: 1),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           const BorderSide(color: kBorderColor, width: 1),
//                     ),
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           const BorderSide(color: Colors.transparent, width: 1),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide:
//                           const BorderSide(color: kErrorColor, width: 1),
//                     ),
//                     contentPadding:
//                         const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
//                   ),
//                 );
//               },
//               hideOnUnfocus: true,
//               showOnFocus: true,
//               focusNode: widget.focusNode,
//               suggestionsCallback: (pattern) async {
//                 // Filter options based on the search pattern and return as a Future
//                 return widget.options
//                     ?.where((option) => (globals.appLang == 'ar'
//                             ? option.nameAr
//                             : option.nameEn)!
//                         .toLowerCase()
//                         .contains(pattern.toLowerCase()))
//                     .toList();
//               },
//               itemBuilder: (context, GetAllLanguageResponse suggestion) {
//                 return ListTile(
//                   title: Text(globals.appLang == 'ar'
//                       ? suggestion.nameAr.toString()
//                       : suggestion.nameEn.toString()),
//                 );
//               },
//               onSelected: (GetAllLanguageResponse suggestion) {
//                 widget.onSelected?.call(suggestion);
//                 widget.focusNode.unfocus();
//                 widget.setShowOptions(false);
//                 if (widget.selectedIndex != null) {
//                   widget.onChanged(widget.selectedIndex!);
//                 }
//               },
//               emptyBuilder: (context) => SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 300,
//                   child: Center(
//                       child:
//                           Text(AppLocalizations.of(context)!.thereIsNoLang))),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

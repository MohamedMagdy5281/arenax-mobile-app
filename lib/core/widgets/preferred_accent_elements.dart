// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:arenax_mobile_app/core/utils/colors.dart';
// import 'package:arenax_mobile_app/core/utils/styles.dart';

// class PreferredAccentElement extends StatefulWidget {
//   const PreferredAccentElement({
//     super.key,
//     required this.label,
//     required this.id,
//     this.selectedIndex,
//     required this.onTap,
//     required this.onIconTap,
//   });

//   final String label;
//   final String id;
//   final String? selectedIndex;
//   final void Function() onTap;
//   final void Function() onIconTap;

//   @override
//   State<PreferredAccentElement> createState() => _PreferredAccentElementState();
// }

// class _PreferredAccentElementState extends State<PreferredAccentElement> {
//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = widget.id == widget.selectedIndex;

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? kBorderColor : kSideBG,
//           border: Border.all(
//             width: 2,
//             color: Colors.transparent,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: kLightBlueColor.withOpacity(.3),
//               spreadRadius: 0,
//               blurRadius: 12,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Center(
//                 child: Text(
//                   widget.label,
//                   style: Styles.textStyle16(context).copyWith(
//                     color: isSelected ? kWhiteColor : kDarkBlackColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: widget.onIconTap,
//               child: Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: kSideBG,
//                   boxShadow: [
//                     BoxShadow(
//                       color: kLightBlueColor.withOpacity(.3),
//                       spreadRadius: 0,
//                       blurRadius: 12,
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Iconsax.volume_high,
//                   size: 20,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

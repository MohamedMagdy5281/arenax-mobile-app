// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:arenax_mobile_app/core/utils/colors.dart';
// import 'package:arenax_mobile_app/core/utils/styles.dart';
// import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';

// class MainGoalsElement extends StatefulWidget {
//   const MainGoalsElement({
//     super.key,
//     required this.imageUrl,
//     required this.label,
//     required this.index,
//     this.selectedIndex,
//     required this.onTap,
//   });

//   final String imageUrl;
//   final String label;
//   final String index;
//   final String? selectedIndex;
//   final void Function() onTap;

//   @override
//   State<MainGoalsElement> createState() => _MainGoalsElementState();
// }

// class _MainGoalsElementState extends State<MainGoalsElement> {
//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = widget.index == widget.selectedIndex;

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? kBorderColor : kSideBG,
//           border: Border.all(width: 2, color: Colors.transparent),
//           borderRadius: BorderRadius.circular(16), // Optional rounded corners
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
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: CachedNetworkImage(
//                 imageUrl: widget.imageUrl,
//                 width: 32,
//                 height: 32,
//                 placeholder: (context, url) => Align(
//                   alignment: Alignment.center,
//                   child: CustomLoadingIndicator(
//                     strokeWidth: 1,
//                     height: 10,
//                     width: 10,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => Container(
//                   width: 32,
//                   height: 32,
//                   decoration: ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         side: BorderSide(
//                           color: isSelected ? kWhiteColor : kDarkBlackColor,
//                         )),
//                   ),
//                   child: Icon(
//                     Icons.error,
//                     color: isSelected ? kWhiteColor : kDarkBlackColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               widget.label,
//               style: Styles.textStyle16(context).copyWith(
//                 color: isSelected ? kWhiteColor : kDarkBlackColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

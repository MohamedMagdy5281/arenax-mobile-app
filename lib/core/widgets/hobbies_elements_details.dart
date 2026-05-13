import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';
import 'custom_loading_indicator.dart';

class HobbiesElementsDetails extends StatelessWidget {
  const HobbiesElementsDetails({
    super.key,
    required this.label,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
    required this.id,
  });

  final String label;
  final String imageUrl;
  final bool isSelected;
  final String id;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kBorderColor : kSideBG,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kLightBlueColor.withOpacity(.3),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 52,
                height: 52,
                placeholder: (context, url) => Align(
                  alignment: Alignment.center,
                  child: const CustomLoadingIndicator(
                    strokeWidth: 1,
                    height: 10,
                    width: 10,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? kWhiteColor : kDarkBlackColor,
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.error,
                    color: isSelected ? kWhiteColor : kDarkBlackColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Styles.textStyle12.copyWith(
                color: isSelected ? kSideBG : kDarkBlackColor,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

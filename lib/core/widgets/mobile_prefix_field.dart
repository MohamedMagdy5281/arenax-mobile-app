import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/assets.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';

class MobilePrefixField extends StatelessWidget {
  const MobilePrefixField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Iconsax.call),
        const SizedBox(width: 8),
        Image.asset(AssetsData.arabicFlage,height: 20,width: 20,),
        const SizedBox(width: 8),
        Text(
          '+966',
          style: Styles.textStyle16,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

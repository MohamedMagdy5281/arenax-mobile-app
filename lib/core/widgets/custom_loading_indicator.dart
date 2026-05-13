import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator(
      {super.key, this.width, this.height, this.color, this.strokeWidth});
  final double? width;
  final double? height;
  final Color? color;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 3 ,
        color: color ?? kPrimaryColor, // Change color
      ),
    );
  }
}

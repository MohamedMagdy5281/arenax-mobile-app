import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/styles.dart';

class CustomTitleWithDescription extends StatelessWidget {
  const CustomTitleWithDescription({super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.textStyle24,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          textAlign: TextAlign.center,
          description,
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}

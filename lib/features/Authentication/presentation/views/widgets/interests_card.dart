import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class InterestsCard extends StatefulWidget {
  final String id;
  final String name;
  final bool isSelected;
  final String image;
  final VoidCallback onTap;
  const InterestsCard(
      {super.key,
      required this.name,
      required this.isSelected,
      required this.image,
      required this.id,
      required this.onTap});

  @override
  State<InterestsCard> createState() => _InterestsCardState();
}

class _InterestsCardState extends State<InterestsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kGrey2Color,
              border: Border.all(
                color: widget.isSelected ? kPrimaryColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.name,
            style: Styles.textStyle14,
          ),
        ],
      ),
    );
  }
}

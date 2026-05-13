import 'package:flutter/material.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';

class CustomRegisterStepper extends StatelessWidget {
  const CustomRegisterStepper(
      {super.key,
        this.firstStepColor,
        this.secondStepColor,
        this.thirdStepColor,
        this.fourthStepColor,
        this.fifthStepColor,
        this.sixthStepColor,
      });

  final Color? firstStepColor;
  final Color? secondStepColor;
  final Color? thirdStepColor;
  final Color? fourthStepColor;
  final Color? fifthStepColor;
  final Color? sixthStepColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 32,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: firstStepColor ?? kLightBlueColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: secondStepColor ?? kLightBlueColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: thirdStepColor ?? kLightBlueColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: fourthStepColor ?? kLightBlueColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: fifthStepColor ?? kLightBlueColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: sixthStepColor ?? kLightBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
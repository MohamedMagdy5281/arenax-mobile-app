import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/Interests_view_body.dart';
import 'package:flutter/material.dart';

class InterestsView extends StatelessWidget {
  const InterestsView({super.key});
  static String id = "InterestsView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: InterestsViewBody()),
      ),
    );
  }
}

import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/enable_face_id_view_body.dart';
import 'package:flutter/material.dart';

class EnableFaceIdView extends StatelessWidget {
  const EnableFaceIdView({super.key});
  static String id = "EnableFaceIdView";
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: colors.kBackGroundColor,
        body: const SafeArea(child: EnableFaceIdViewBody()),
      ),
    );
  }
}

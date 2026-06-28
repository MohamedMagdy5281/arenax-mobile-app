import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  static String id = "EditProfileView";

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
        body: EditProfileViewBody(),
      ),
    );
  }
}

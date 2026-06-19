import 'package:arenax_mobile_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static String id = "ProfileView";

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
        body: Stack(
          children: [
            ProfileViewBody(),
            Positioned(
              bottom: 0,
              child: CustomBottomNavBar(
                currentIndex: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

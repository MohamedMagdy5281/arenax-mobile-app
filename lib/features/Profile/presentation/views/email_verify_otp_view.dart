import 'dart:io';

import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/email_verify_otp_view_body.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';

class EmailVerifyOtpView extends StatelessWidget {
  const EmailVerifyOtpView({super.key});
  static String id = "EmailVerifyOtpView";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String firstName = args['firstName'].toString();
    final String lastName = args['lastName'].toString();
    final String email = args['email'].toString();
    final String phoneNumber = args['phoneNumber'].toString();
    final File? profilePic = args['profilePic'];

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
        body: EmailVerifyOtpViewBody(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profilePic: profilePic,
        ),
      ),
    );
  }
}

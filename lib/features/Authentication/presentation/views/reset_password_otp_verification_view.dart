import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/reset_password_otp_verification_view_body.dart';
import 'package:flutter/material.dart';

class ResetPasswordOtpVerificationView extends StatelessWidget {
  const ResetPasswordOtpVerificationView({super.key});
  static String id = "ResetPasswordOtpVerificationView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String phoneNumber = args['phoneNumber'].toString();

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
        body: SafeArea(
            child: ResetPasswordOtpVerificationViewBody(
          phoneNumber: phoneNumber,
        )),
      ),
    );
  }
}

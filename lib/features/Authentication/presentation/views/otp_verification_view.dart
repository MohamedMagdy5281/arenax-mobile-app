import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/otp_verification_view_body.dart';
import 'package:flutter/material.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});
  static String id = "OtpVerificationView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: OtpVerificationViewBody()),
      ),
    );
  }
}

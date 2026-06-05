import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/auth_Intro_view_body.dart';
import 'package:flutter/material.dart';

class AuthIntroView extends StatelessWidget {
  const AuthIntroView({super.key});
  static String id = "AuthIntroView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: AuthIntroViewBody()),
      ),
    );
  }
}

import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static String id = "RegisterView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: RegisterViewBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/login_otp_view_body.dart';

class LoginOtpView extends StatelessWidget {
  const LoginOtpView({super.key});
  static String id = "LoginOtpView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String loginId = args['loginId'];
    return BlocProvider(
      create: (context) => LoginCubit()..startTimer(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: LoginOtpViewBody(loginId: loginId),
        ),
      ),
    );
  }
}

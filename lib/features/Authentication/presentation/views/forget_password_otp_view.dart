import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/forget_password_otp_view_body.dart';

class ForgetPasswordOtpView extends StatelessWidget {
  const ForgetPasswordOtpView({super.key});
  static String id = "ForgetPasswordOtpView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String requestId = args['requestId'];
    return BlocProvider(
      create: (context) => ResetPasswordCubit()..startTimer(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: ForgetPasswordOtpViewBody(requestId: requestId),
        ),
      ),
    );
  }
}

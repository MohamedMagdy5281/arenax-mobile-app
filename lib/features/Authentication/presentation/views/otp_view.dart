import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/otp_view_body.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});
  static String id = "OtpView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String registerationId = args['registerationId'];
    return BlocProvider(
      create: (context) => RegisterCubit()..startTimer(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: OtpViewBody(registerationId: registerationId),
        ),
      ),
    );
  }
}

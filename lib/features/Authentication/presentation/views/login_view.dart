import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = "LoginView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..loginInit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: LoginViewBody(),
        ),
      ),
    );
  }
}

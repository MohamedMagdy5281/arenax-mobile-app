import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/app_loader_after_login_cubit/app_loader_after_login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/app_loader_after_login_view_body.dart';

class AppLoaderAfterLoginView extends StatelessWidget {
  const AppLoaderAfterLoginView({super.key});
  static String id = "AppLoaderAfterLoginView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoaderAfterLoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: AppLoaderAfterLoginViewBody(),
      ),
    );
  }
}

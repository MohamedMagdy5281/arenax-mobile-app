import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_target_accent_cubit/assign_target_accent_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/choose_accent_view_body.dart';

class ChooseAccentView extends StatelessWidget {
  const ChooseAccentView({super.key});
  static String id = "ChooseAccentView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignTargetAccentCubit()..getAllAccentInitialize(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: ChooseAccentViewBody(),
      ),
    );
  }
}

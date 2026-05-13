import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/choose_gender_view_body.dart';

class ChooseGenderView extends StatelessWidget {
  const ChooseGenderView({super.key});
  static String id = "ChooseGenderView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignUserDataCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: ChooseGenderViewBody(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/first_last_name_assign_cubit/first_last_name_assign_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/first_last_name_assign_view_body.dart';
import 'package:praktika_clone_app/features/Profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/widgets/edit_profile_view_body.dart';

class FirstLastNameAssignView extends StatelessWidget {
  const FirstLastNameAssignView({super.key});
  static String id = "FirstLastNameAssignView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirstLastNameAssignCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: FirstLastNameAssignViewBody(),
        ),
      ),
    );
  }
}

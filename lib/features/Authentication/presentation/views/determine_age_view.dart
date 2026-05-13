import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/determine_age_view_body.dart';

class DetermineAgeView extends StatelessWidget {
  const DetermineAgeView({super.key});
  static String id = "DetermineAgeView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String gender = args['gender'];
    return BlocProvider(
      create: (context) => AssignUserDataCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: DetermineAgeViewBody(gender: gender),
        ),
      ),
    );
  }
}

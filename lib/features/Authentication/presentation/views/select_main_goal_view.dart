import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_main_goal_cubit/assign_main_goal_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/select_main_goal_view_body.dart';

class SelectMainGoalView extends StatelessWidget {
  const SelectMainGoalView({super.key});
  static String id = "SelectMainGoalView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignMainGoalCubit()..getAllGoalsInitialize(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: SelectMainGoalViewBody(),
      ),
    );
  }
}

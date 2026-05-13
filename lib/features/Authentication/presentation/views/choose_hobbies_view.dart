import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_interest_cubit/assign_user_interest_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/choose_hobbies_view_body.dart';

class ChooseHobbiesView extends StatelessWidget {
  const ChooseHobbiesView({super.key});
  static String id = "ChooseHobbiesView";
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AssignUserInterestCubit()..getAllInterestsInitialize(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: ChooseHobbiesViewBody(),
      ),
    );
  }
}

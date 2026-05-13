import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/select_language_view_body.dart';

class SelectLanguageView extends StatelessWidget {
  const SelectLanguageView({super.key});
  static String id = "SelectLanguageView";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String gender = args['gender'];
    DateTime dateOfBirth = args['dateOfBirth'];
    return BlocProvider(
      create: (context) => AssignUserDataCubit()..getLanguages(1),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: SelectLanguageViewBody(
            gender:gender,
            dateOfBirth: dateOfBirth,
        ),
      ),
    );
  }
}

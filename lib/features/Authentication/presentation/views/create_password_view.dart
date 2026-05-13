import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/widgets/create_password_view_body.dart';

class CreatePasswordView extends StatelessWidget {
  const CreatePasswordView({super.key});
  static String id = "CreatePasswordView";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String firstName = args['firstName'];
    String lastName = args['lastName'];
    String email = args['email'];
    String phone = args['phone'];
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kBGColor,
          body: CreatePasswordViewBody(
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone),
        ),
      ),
    );
  }
}

import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/app_loader_view_body.dart';
import 'package:flutter/material.dart';

class AppLoaderView extends StatelessWidget {
  const AppLoaderView({super.key});
  static String id = "AppLoaderView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: AppLoaderViewBody()),
      ),
    );
  }
}

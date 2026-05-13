import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/widgets/custom_loading_indicator.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/app_loader_after_login_cubit/app_loader_after_login_cubit.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/app_loader_after_login_cubit/app_loader_after_login_state.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/supscriptioin_view.dart';

class AppLoaderAfterLoginViewBody extends StatefulWidget {
  const AppLoaderAfterLoginViewBody({super.key});

  @override
  State<AppLoaderAfterLoginViewBody> createState() =>
      _AppLoaderAfterLoginViewBodyState();
}

class _AppLoaderAfterLoginViewBodyState
    extends State<AppLoaderAfterLoginViewBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppLoaderAfterLoginCubit, AppLoaderAfterLoginState>(
      listener: (context, state) {
        if (state is GetCurrentUserSuccess) {
          if (globals.isSubscriptionActive == true) {
            globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
              HomeView.id,
              (route) => false,
            );
          } else if (globals.isFreeTrialActive == true) {
            globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
              HomeView.id,
              (route) => false,
            );
          } else {
            globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
              SupscriptioinView.id,
              (route) => false,
            );
          }
          // if (globals.validatedSubscriptionItems.isEmpty) {
          //   if (globals.isFreeTrialActive) {
          //     globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          //       HomeView.id,
          //       (route) => false,
          //     );
          //   } else {
          //     globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          //       SupscriptioinView.id,
          //       (route) => false,
          //     );
          //   }
          // } else {
          //   if (globals.validatedSubscriptionItems.last.isActive! == true) {
          //     globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          //       HomeView.id,
          //       (route) => false,
          //     );
          //   } else {
          //     globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          //       SupscriptioinView.id,
          //       (route) => false,
          //     );
          //   }
          // }
        } else if (state is GetCurrentUserFailure) {
          globals.navigatorKey.currentState!.pushNamedAndRemoveUntil(
            SupscriptioinView.id,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CustomLoadingIndicator(),
          ),
        );
      },
    );
  }
}

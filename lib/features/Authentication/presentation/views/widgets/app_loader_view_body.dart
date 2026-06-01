import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/appLoaderRiverpod/app_loader_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class AppLoaderViewBody extends ConsumerStatefulWidget {
  const AppLoaderViewBody({super.key});

  @override
  ConsumerState<AppLoaderViewBody> createState() => _AppLoaderViewBodyState();
}

class _AppLoaderViewBodyState extends ConsumerState<AppLoaderViewBody> {
  @override
  void initState() {
    super.initState();
    ref.read(appLoaderNotifierProvider.notifier).initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CustomLoadingIndicator(),
      ),
    );
  }
}

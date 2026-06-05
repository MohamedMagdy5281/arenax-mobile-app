import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
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
    return Container(
      color: kBackGroundColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsData.logo, width: 120, height: 120),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Arena',
                style: Styles.textStyle32.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              SizedBox(width: 1),
              Text(
                'X',
                style: Styles.textStyle32.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kAccentColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.findBookPlayTogether,
            style: Styles.textStyle14.copyWith(
              color: kTextMutedColor,
            ),
          ),
          const SizedBox(height: 52),
          const CustomLoadingIndicator(
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}

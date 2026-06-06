import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';

class NoItemsWidget extends StatelessWidget {
  final String text;
  const NoItemsWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .2,
          ),
          Text(
            text,
            style: Styles.textStyle20(context),
          ),
        ],
      ),
    );
  }
}

class ErrorLoadingItem extends StatelessWidget {
  final void Function() onTap;
  final String failedText;
  const ErrorLoadingItem({
    super.key,
    required this.onTap,
    required this.failedText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              failedText,
              style: Styles.textStyle16(context),
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.tryAgainMsg,
              style: Styles.textStyle16(context),
            ),
            SizedBox(height: 16),
            CustomButton(
              width: 150,
              height: 50,
              text: AppLocalizations.of(context)!.retry,
              itemCallBack: onTap,
            )
          ],
        ),
      ),
    );
  }
}

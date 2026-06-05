import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/login_view.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class AuthIntroViewBody extends StatelessWidget {
  const AuthIntroViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackGroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Image.asset(AssetsData.logo,
                                  width: 120, height: 120),
                              SizedBox(height: 24),
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
                              SizedBox(height: 32),
                              Column(children: [
                                Text(
                                  AppLocalizations.of(context)!.findBookPlay,
                                  style: Styles.textStyle32.copyWith(
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.together,
                                  style: Styles.textStyle24.copyWith(
                                    color: kAccentColor,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(context)!.bookThenSplit,
                                textAlign: TextAlign.center,
                                style: Styles.textStyle16.copyWith(
                                  color: kTextMutedColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                text: AppLocalizations.of(context)!
                                    .continueWithPhone,
                                itemCallBack: () {
                                  globals.navigatorKey.currentState!
                                      .pushNamed(RegisterView.id);
                                },
                              ),
                              SizedBox(height: 16),
                              CustomButtonWithNoBG(
                                text: AppLocalizations.of(context)!
                                    .iAlreadyHaveAnAccount,
                                itemCallBack: () {
                                  globals.navigatorKey.currentState!
                                      .pushNamed(LoginView.id);
                                },
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .byContinuingYouAgreeToOur,
                                    style: Styles.textStyle14.copyWith(
                                      color: kHintColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Handle terms tap
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.terms,
                                          style: Styles.textStyle14.copyWith(
                                            color: kTextMutedColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: kTextMutedColor,
                                            decorationThickness: 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '-',
                                        style: Styles.textStyle14.copyWith(
                                          color: kHintColor,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          // Handle privacy tap
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.privacy,
                                          style: Styles.textStyle14.copyWith(
                                            color: kTextMutedColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: kTextMutedColor,
                                            decorationThickness: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 32),
                            ],
                          )
                        ]),
                  )
                ])));
  }
}

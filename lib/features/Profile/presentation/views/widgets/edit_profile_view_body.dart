import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/styles.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:arenax_mobile_app/core/widgets/custom_header.dart';
import 'package:arenax_mobile_app/core/widgets/custom_loading_indicator.dart';
import 'package:arenax_mobile_app/core/widgets/text_form_field_with_title.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/manager/editProfileRiverpod/edit_profile_notifier_provider.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/email_verify_otp_view.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/profile_view.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/email_verify_otp_view_body.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/widgets/image_picker_option_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:iconsax/iconsax.dart';

class EditProfileViewBody extends ConsumerStatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  ConsumerState<EditProfileViewBody> createState() =>
      _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends ConsumerState<EditProfileViewBody> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> editProfileFormKey = GlobalKey();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    firstNameController.text = globals.userDetails.firstName != null
        ? globals.userDetails.firstName!
        : "";
    lastNameController.text = globals.userDetails.lastName != null
        ? globals.userDetails.lastName!
        : "";
    emailController.text =
        globals.userDetails.email != null ? globals.userDetails.email! : "";
    phoneController.text = globals.userDetails.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editProfileNotifierProvider);
    final notifier = ref.read(editProfileNotifierProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return state.isPageLoading
        ? Container(
            color: colors.kInfoTextColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: CustomLoadingIndicator(),
              ),
            ))
        : Container(
            color: colors.kBackGroundColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        CustomHeader(
                          title: AppLocalizations.of(context)!.editProfile,
                          onPrefixIconTap: () {
                            notifier.resetChanges();
                            globals.navigatorKey.currentState!.pop();
                          },
                          optionalPrefixIcon: Container(
                            decoration: BoxDecoration(
                              color: colors.kSurfaceColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 38,
                            height: 38,
                            child: Icon(
                              globals.appLang == "en"
                                  ? Iconsax.arrow_left_2
                                  : Iconsax.arrow_right_3,
                              color: colors.kTextColor,
                              size: 12,
                            ),
                          ),
                          optionalSuffixIcon: Text(
                            AppLocalizations.of(context)!.save,
                            style: Styles.textStyle14(context).copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.kPrimaryColor),
                          ),
                          onSuffixIconTap: () {
                            if (editProfileFormKey.currentState!.validate()) {
                              if (globals.userEmailVerified == true) {
                                CasheHelper.selectedImage = state.selectedImage;
                                globals.userDetails.firstName =
                                    firstNameController.text.trim();
                                globals.userDetails.lastName =
                                    lastNameController.text.trim();
                                globals.userDetails.email =
                                    emailController.text.trim();
                                globals.navigatorKey.currentState!
                                    .pushNamed(ProfileView.id);
                              } else {
                                globals.navigatorKey.currentState!.pushNamed(
                                    EmailVerifyOtpView.id,
                                    arguments: {
                                      "firstName":
                                          firstNameController.text.trim(),
                                      "lastName":
                                          lastNameController.text.trim(),
                                      "email": emailController.text.trim(),
                                      "phoneNumber":
                                          phoneController.text.trim(),
                                      "profilePic": state.selectedImage
                                    });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        state.selectedImage != null
                            ? Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 88,
                                      height: 88,
                                      decoration: BoxDecoration(
                                        color: colors.kUserNameShortcutBGColor,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          state.selectedImage!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -2,
                                      right: -2,
                                      child: GestureDetector(
                                        onTap: () {
                                          ImagePickerOptionBottomSheet.show(
                                            context,
                                            onCameraSelect: () {
                                              Navigator.pop(context);
                                              notifier.pickCameraImage(context);
                                            },
                                            onGallerySelect: () {
                                              Navigator.pop(context);
                                              notifier
                                                  .pickGalleryImage(context);
                                            },
                                            onRemoveImageSelect: () {
                                              Navigator.pop(context);
                                              notifier.removeImage(context);
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: colors.kPrimaryColor,
                                              border: Border.all(
                                                  width: 3,
                                                  color:
                                                      colors.kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Icon(
                                            Icons.edit,
                                            size: 14,
                                            color: colors.kWhiteColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : globals.userDetails.firstName == null ||
                                    globals.userDetails.lastName == null
                                ? Center(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 88,
                                        height: 88,
                                        decoration: BoxDecoration(
                                          color: colors.kPrimaryDarkColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: Styles.textStyle18(context)
                                                .copyWith(
                                                    color:
                                                        colors.kPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 88,
                                          height: 88,
                                          decoration: BoxDecoration(
                                            color:
                                                colors.kUserNameShortcutBGColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${globals.userDetails.firstName![0]}${globals.userDetails.lastName![0]}",
                                              style: Styles.textStyle18(context)
                                                  .copyWith(
                                                      color: colors
                                                          .kUserNameShortcutTextColor),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -2,
                                          right: -2,
                                          child: GestureDetector(
                                            onTap: () {
                                              ImagePickerOptionBottomSheet.show(
                                                context,
                                                onCameraSelect: () {
                                                  Navigator.pop(context);
                                                  notifier
                                                      .pickCameraImage(context);
                                                },
                                                onGallerySelect: () {
                                                  Navigator.pop(context);
                                                  notifier.pickGalleryImage(
                                                      context);
                                                },
                                                onRemoveImageSelect: () {
                                                  Navigator.pop(context);
                                                  notifier.removeImage(context);
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: colors.kPrimaryColor,
                                                  border: Border.all(
                                                      width: 3,
                                                      color: colors
                                                          .kBackGroundColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: colors.kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.tapToChangePhoto,
                            style: Styles.textStyle12(context)
                                .copyWith(color: colors.kTextMutedColor),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: editProfileFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormFieldWithTitle(
                                  controller: firstNameController,
                                  title:
                                      AppLocalizations.of(context)!.firstName,
                                  placeholder: AppLocalizations.of(context)!
                                      .enterFirstName,
                                  validator: (String? pass) {
                                    final value = pass ?? "";

                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .cantBeEmpty;
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                TextFormFieldWithTitle(
                                  controller: lastNameController,
                                  title: AppLocalizations.of(context)!.lastName,
                                  placeholder: AppLocalizations.of(context)!
                                      .enterLastName,
                                  validator: (String? pass) {
                                    final value = pass ?? "";

                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .cantBeEmpty;
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                TextFormFieldWithTitle(
                                  controller: emailController,
                                  title: AppLocalizations.of(context)!.email,
                                  placeholder:
                                      AppLocalizations.of(context)!.enterEmail,
                                  titleAdditionalInfo: globals
                                              .userEmailVerified ==
                                          true
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: colors.kSuccessTextColor,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .verified,
                                              style: Styles.textStyle12(context)
                                                  .copyWith(
                                                      color: colors
                                                          .kSuccessTextColor),
                                            )
                                          ],
                                        )
                                      : null,
                                  validator: (String? pass) {
                                    final value = pass ?? "";

                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .cantBeEmpty;
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                TextFormFieldWithTitle(
                                  controller: phoneController,
                                  title: AppLocalizations.of(context)!.phone,
                                  placeholder:
                                      AppLocalizations.of(context)!.enterPhone,
                                  disabled: true,
                                  validator: (String? pass) {
                                    final value = pass ?? "";

                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .cantBeEmpty;
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.contactSupp,
                                  style: Styles.textStyle12(context)
                                      .copyWith(color: colors.kTextMutedColor),
                                )
                              ],
                            ))
                      ])))
                ])));
  }
}

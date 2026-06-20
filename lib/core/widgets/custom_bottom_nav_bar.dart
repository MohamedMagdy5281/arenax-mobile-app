import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;
import 'package:arenax_mobile_app/core/widgets/custom_bottom_nav_bar_button.dart';
// import 'package:arenax_mobile_app/features/Courses/presentation/views/courses_view.dart';
// import 'package:arenax_mobile_app/features/Home/presentaion/views/home_view.dart';
// import 'package:arenax_mobile_app/features/Profile/presentation/views/profile_view.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int chosenIndex = widget.currentIndex;

  void _updateIndex(int index) {
    setState(() {
      chosenIndex = index;
    });
  }

  void _homeClicked() {
    if (chosenIndex != 0) {
      _updateIndex(0);
      // globals.navigatorKey.currentState!.pushNamed(HomeView.id);
    }
  }

  void _searchClicked() {
    if (chosenIndex != 1) {
      _updateIndex(1);
      // globals.navigatorKey.currentState!.pushNamed(CoursesView.id);
    }
  }

  void _bookingClicked() {
    if (chosenIndex != 2) {
      _updateIndex(2);
      // globals.navigatorKey.currentState!.pushNamed(ProfileView.id);
    }
  }

  void _crewClicked() {
    if (chosenIndex != 3) {
      _updateIndex(3);
      // globals.navigatorKey.currentState!.pushNamed(ProfileView.id);
    }
  }

  void _profileClicked() {
    if (chosenIndex != 4) {
      _updateIndex(4);
      // globals.navigatorKey.currentState!.pushNamed(ProfileView.id);
    }
  }

  // void _profileClicked() {
  //   if (chosenIndex != 3) {
  //     _updateIndex(3);
  //     // globals.navigatorKey.currentState!.pushNamed(ProfileHomeView.id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark
            : AppColors.light);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.kDisabledButtonColor)),
            color: colors.kSurfaceColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBottomNavBarButton(
                  onPressed: _homeClicked,
                  icon: chosenIndex == 0
                      ? Icons.home_outlined
                      : Icons.home_outlined,
                  iconColor: chosenIndex == 0
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  iconContainerColor: chosenIndex == 0
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  label: AppLocalizations.of(context)!.home,
                  labelColor: chosenIndex == 0
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                ),
                CustomBottomNavBarButton(
                  onPressed: _searchClicked,
                  icon: chosenIndex == 1
                      ? Iconsax.search_normal_1
                      : Iconsax.search_normal_1,
                  iconColor: chosenIndex == 1
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  iconContainerColor: chosenIndex == 1
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  label: AppLocalizations.of(context)!.search,
                  labelColor: chosenIndex == 1
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                ),
                CustomBottomNavBarButton(
                  onPressed: _bookingClicked,
                  icon: chosenIndex == 2
                      ? Iconsax.calendar_2
                      : Iconsax.calendar_2,
                  iconColor: chosenIndex == 2
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  iconContainerColor: chosenIndex == 2
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  label: AppLocalizations.of(context)!.booking,
                  labelColor: chosenIndex == 2
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                ),
                CustomBottomNavBarButton(
                  onPressed: _crewClicked,
                  icon: chosenIndex == 3
                      ? Icons.person_outline
                      : Icons.person_outline,
                  iconColor: chosenIndex == 3
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  iconContainerColor: chosenIndex == 3
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  label: AppLocalizations.of(context)!.crew,
                  labelColor: chosenIndex == 3
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                ),
                CustomBottomNavBarButton(
                  onPressed: _profileClicked,
                  icon: chosenIndex == 4
                      ? Icons.person_outline
                      : Icons.person_outline,
                  iconColor: chosenIndex == 4
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  iconContainerColor: chosenIndex == 4
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  label: AppLocalizations.of(context)!.profile,
                  labelColor: chosenIndex == 4
                      ? colors.kPrimaryColor
                      : colors.kHintColor,
                  warningAlert: globals.userDetails.firstName == null ||
                          globals.userDetails.lastName == null ||
                          globals.userDetails.email == null
                      ? true
                      : false,
                ),
                // CustomBottomNavBarButton(
                //     onPressed: _profileClicked,
                //     icon: chosenIndex == 3
                //         ? Iconsax.profile_circle5
                //         : Iconsax.profile_circle4,
                //     iconText: "",
                //     iconColor: chosenIndex == 3 ? kPrimaryColor : kSubTitleColor,
                //     iconTextColor:
                //         chosenIndex == 3 ? kPrimaryColor : kSubTitleColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

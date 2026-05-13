import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/widgets/custom_bottom_nav_bar_button.dart';
import 'package:praktika_clone_app/features/Courses/presentation/views/courses_view.dart';
import 'package:praktika_clone_app/features/Home/presentaion/views/home_view.dart';
import 'package:praktika_clone_app/features/Profile/presentation/views/profile_view.dart';

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
      globals.navigatorKey.currentState!.pushNamed(HomeView.id);
    }
  }

  void _coursesClicked() {
    if (chosenIndex != 1) {
      _updateIndex(1);
      globals.navigatorKey.currentState!.pushNamed(CoursesView.id);
    }
  }

  void _profileClicked() {
    if (chosenIndex != 2) {
      _updateIndex(2);
      globals.navigatorKey.currentState!.pushNamed(ProfileView.id);
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          width: 288,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: kSideBG,
            boxShadow: [
              BoxShadow(
                color: kLightBlueColor.withOpacity(0.4),
                // Adjust opacity as needed
                offset: Offset(1, 1), // X and Y offset
                blurRadius: 20, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBottomNavBarButton(
                    onPressed: _homeClicked,
                    icon: chosenIndex == 0 ? Iconsax.home : Iconsax.home,
                    iconColor: chosenIndex == 0 ? kWhiteColor : kDarkBlackColor,
                    iconContainerColor:
                        chosenIndex == 0 ? kPrimaryColor : Colors.transparent),
                CustomBottomNavBarButton(
                    onPressed: _coursesClicked,
                    icon: chosenIndex == 1 ? Iconsax.note_2 : Iconsax.note_2,
                    iconColor: chosenIndex == 1 ? kWhiteColor : kDarkBlackColor,
                    iconContainerColor:
                        chosenIndex == 1 ? kPrimaryColor : Colors.transparent),
                CustomBottomNavBarButton(
                    onPressed: _profileClicked,
                    icon: chosenIndex == 2
                        ? Iconsax.profile_circle
                        : Iconsax.profile_circle,
                    iconColor: chosenIndex == 2 ? kWhiteColor : kDarkBlackColor,
                    iconContainerColor:
                        chosenIndex == 2 ? kPrimaryColor : Colors.transparent),
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

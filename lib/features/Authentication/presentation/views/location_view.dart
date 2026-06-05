import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/views/widgets/location_view_body.dart';
import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});
  static String id = "LocationView";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBGColor,
        body: const SafeArea(child: LocationViewBody()),
      ),
    );
  }
}

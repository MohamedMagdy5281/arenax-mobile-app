import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:praktika_clone_app/core/utils/colors.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/core/utils/styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 55,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: kSideBG,
        boxShadow: [
          BoxShadow(
            color: kLightBlueColor.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 16,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => globals.navigatorKey.currentState!.pop(),
            child: globals.appLang == 'ar'
                ? Icon(Iconsax.arrow_right_1)
                : Icon(Iconsax.arrow_left),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

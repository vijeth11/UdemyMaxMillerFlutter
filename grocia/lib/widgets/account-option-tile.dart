import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class AccountOptionTile extends StatelessWidget {
  final String titleName;
  // format [Icon, color]
  final List leadingIcon;
  final VoidCallback onTap;
  bool displayArrowIcon;
  bool displayBoxArroundArrowIcon;
  static const double leadingIconsSize = 40;
  AccountOptionTile(
      {super.key,
      required this.titleName,
      required this.leadingIcon,
      required this.onTap,
      this.displayArrowIcon = true,
      this.displayBoxArroundArrowIcon = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon.length == 2
          ? Container(
              height: leadingIconsSize,
              width: leadingIconsSize,
              decoration: BoxDecoration(
                  color: leadingIcon[1],
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                leadingIcon[0],
                color: kWhiteColor,
              ),
            )
          : null,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(titleName),
        if (displayArrowIcon)
          Container(
            padding: const EdgeInsets.all(3),
            decoration: displayBoxArroundArrowIcon ? BoxDecoration(
                color: kGreenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)): null,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: displayBoxArroundArrowIcon ? kGreenColor:kBlackColor,
            ),
          )
      ]),
      onTap: onTap,
    );
  }
}

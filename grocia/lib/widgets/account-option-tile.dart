import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class AccountOptionTile extends StatelessWidget {
  final String titleName;
  final List leadingIcon;
  final VoidCallback onTap;
  bool displayArrowIcon;
  static const double leadingIconsSize = 40;
  AccountOptionTile(
      {super.key,
      required this.titleName,
      required this.leadingIcon,
      required this.onTap,
      this.displayArrowIcon = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: leadingIconsSize,
        width: leadingIconsSize,
        decoration: BoxDecoration(
            color: leadingIcon[1], borderRadius: BorderRadius.circular(25)),
        child: Icon(
          leadingIcon[0],
          color: kWhiteColor,
        ),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(titleName),
        if(displayArrowIcon)
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: kGreenColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: kGreenColor,
          ),
        )
      ]),
      onTap: onTap,
    );
  }
}

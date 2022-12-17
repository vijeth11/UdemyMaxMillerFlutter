import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:routemaster/routemaster.dart';

AppBar BackActionAppBar(BuildContext context, String title,
    {Color backgroundColor = kGreyLightColor}) {
  return AppBar(
    //TODO: Create a Drawer app
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: kBlackColor,
          ))
    ],
    foregroundColor: kBlackColor,
    backgroundColor: backgroundColor,
    elevation: 0.0,
    titleSpacing: 0.0,
    leading: TextButton(
      onPressed: () {
        Routemaster.of(context).pop();
      },
      child: Text(
        String.fromCharCode(Icons.arrow_back_ios_new_rounded.codePoint),
        style: TextStyle(
            inherit: false,
            color: kGreenColor,
            fontSize: 19,
            fontWeight: FontWeight.w900,
            fontFamily: Icons.arrow_back_ios_new_rounded.fontFamily,
            package: Icons.arrow_back_ios_new_rounded.fontPackage),
      ),
    ),
    title: Text(
      title,
      style: screenHeaderStyle,
    ),
  );
}

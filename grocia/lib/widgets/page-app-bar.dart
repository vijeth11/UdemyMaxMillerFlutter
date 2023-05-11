import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

AppBar getPageAppBar(String title, BuildContext context,{Color? backGroundColor}) {
  return AppBar(
    elevation: 1,
    backgroundColor: backGroundColor ?? kWhiteColor,
    title: Text(
      title,
      style: TextStyle(color: kBlackColor),
    ),
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: kGreyColor,
          ))
    ],
  );
}

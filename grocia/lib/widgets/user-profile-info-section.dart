import 'package:flutter/material.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/screen/account_screen.dart';
import 'package:routemaster/routemaster.dart';

import '../constants/colors.dart';

class UserProfileInfoSection extends StatelessWidget {
  final UserModel item;
  final bool isEdit;
  const UserProfileInfoSection(
      {super.key, required this.item, required this.isEdit});

  static const double profileImageSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: kGreyLightColor,
      child: Column(
        children: [
          // profile Image
          Padding(
            padding: const EdgeInsets.only(top: 22.0, bottom: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  item.profileImage,
                  height: profileImageSize,
                  width: profileImageSize,
                  fit: BoxFit.cover,
                )),
          ),
          // user display name
          Text(
            item.displayName,
            style: screenHeaderStyle,
          ),
          const SizedBox(
            height: 4,
          ),
          // user email
          Text(
            item.userEmail,
            style: const TextStyle(color: kGreyColor),
          ),
          const SizedBox(
            height: 10,
          ),
          if (!isEdit) editProfileButton(context),
          if (!isEdit)
            const SizedBox(
              height: 22,
            ),
        ],
      ),
    );
  }

  DecoratedBox editProfileButton(BuildContext context) {
    return DecoratedBox(
      decoration: buttonStyle.copyWith(borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
        onPressed: () =>
            {Routemaster.of(context).push("${AccountScreen.routeName}/edit")},
        style:
            ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              Icons.edit,
              color: kWhiteColor,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Edit Profile",
              style: TextStyle(color: kWhiteColor),
            )
          ],
        ),
      ),
    );
  }
}

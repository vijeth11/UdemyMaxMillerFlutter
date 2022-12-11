import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account';
  static const int iconIndex = 3;
  static const double profileImageSize = 120.0;
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel item = Provider.of<AuthProvider>(context, listen: false).item;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // TODO: open a drawer on click of menu
              },
              icon: const Icon(
                Icons.menu,
                color: kBlackColor,
              ))
        ],
        foregroundColor: kBlackColor,
        backgroundColor: kGreyLightColor,
        elevation: 1.0,
        title: const Text(
          "My Account",
          style: screenHeaderStyle,
        ),
      ),
      body: Column(
        children: [getProfileInfoSection(item)],
      ),
      bottomNavigationBar: const BottomNavigation(activeItemIndex: iconIndex),
    );
  }

  Widget getProfileInfoSection(UserModel item) {
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
          editProfileButton(),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }

  DecoratedBox editProfileButton() {
    return DecoratedBox(
      decoration: buttonStyle.copyWith(borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
        onPressed: () => {
          // TODO open new page for editing
        },
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

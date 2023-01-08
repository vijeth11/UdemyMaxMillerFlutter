import 'package:flutter/material.dart';
import 'package:grocia/constants/account-info.constants.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/screen/user_address_screen.dart';
import 'package:grocia/widgets/account-option-tile.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:grocia/widgets/user-profile-info-section.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account';
  static const int iconIndex = 3;
  static const String addressTitle = "My Address";
  static const String termsTitle = "Terms, Privacy & Policy";
  static const String helpTitle = "Help & Support";
  static const String logout = "Logout";
  static const List<Map<String, List>> options = [
    {
      addressTitle: [Icons.contacts, kBlackColor]
    },
    {
      termsTitle: [Icons.info, kBlueColor]
    },
    {
      helpTitle: [Icons.phone, kOrangeColor]
    },
    {
      logout: [Icons.lock, kRedColor]
    }
  ];
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
        children: [
          UserProfileInfoSection(item:item, isEdit: false,),
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              itemBuilder: (ctx, index) {
                return AccountOptionTile(
                    titleName: options[index].keys.first,
                    leadingIcon: options[index].values.first,
                    displayArrowIcon: index != options.length - 1,
                    onTap: () {
                      switch (options[index].keys.first) {
                        case addressTitle:
                          Routemaster.of(context)
                              .push(UserAddressScreen.routeName);
                          break;
                        case termsTitle:
                          Routemaster.of(context).push(
                              "${AccountScreen.routeName}/$TermsAndPrivacyAndCondition");
                          break;
                        case helpTitle:
                          Routemaster.of(context).push(
                              "${AccountScreen.routeName}/$HelpAndSupport");
                          break;
                        case logout:
                          // implement logout
                          Routemaster.of(context).pop();
                          break;
                      }
                    });
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(activeItemIndex: iconIndex),
    );
  }
}

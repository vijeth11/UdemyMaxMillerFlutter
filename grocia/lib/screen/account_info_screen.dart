import 'package:flutter/material.dart';
import 'package:grocia/constants/account-info.constants.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/pages/account_faq_page.dart';
import 'package:grocia/screen/account_screen.dart';
import 'package:grocia/widgets/account-option-tile.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:routemaster/routemaster.dart';

class AccountInfoScreen extends StatelessWidget {
  final String infoType;
  const AccountInfoScreen({super.key, required this.infoType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackActionAppBar(context, getPageHeader(),
          backgroundColor: infoType == TermsAndPrivacyAndCondition
              ? kGreyColor.withOpacity(0.15)
              : kWhiteColor),
      body: getInfoBody(context),
    );
  }

  Widget getInfoBody(BuildContext context) {
    switch (infoType) {
      case TermsAndPrivacyAndCondition:
        return Column(
          children: [
            AccountOptionTile(
                titleName: "Terms & Conditions",
                leadingIcon: [],
                onTap: () => {
                      Routemaster.of(context)
                          .push("${AccountScreen.routeName}/$TermsAndCondition")
                    }),
            const Divider(
              thickness: 1,
            ),
            AccountOptionTile(
                titleName: "Privacy",
                leadingIcon: [],
                onTap: () => {
                      Routemaster.of(context)
                          .push("${AccountScreen.routeName}/$Privacy")
                    }),
            const Divider(
              thickness: 1,
            ),
            AccountOptionTile(
                titleName: "FAQ",
                leadingIcon: [],
                onTap: () => {
                      Routemaster.of(context)
                          .push("${AccountScreen.routeName}/$Faq")
                    }),
            const Divider(
              thickness: 1,
            ),
          ],
        );
      case Privacy:
        return getInfoDetailSection("Privacy");
      case TermsAndCondition:
        return getInfoDetailSection("Terms & Conditions");
      // case HelpAndSupport:
      //   return Container();
      case Faq:
        return AccountFAQPage();
      default:
        return const Center(
          child: Text("Need to be implemented"),
        );
    }
  }

  String getPageHeader() {
    switch (infoType) {
      case TermsAndCondition:
        return "Terms & Conditions";
      case Privacy:
        return "Privacy";
      case Faq:
        return "FAQ";
      default:
        return "";
    }
  }

  Widget getInfoDetailSection(String title) {
    return Container(
      color: kGreyLightColor,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            """Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            """Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          )
        ],
      ),
    );
  }
}

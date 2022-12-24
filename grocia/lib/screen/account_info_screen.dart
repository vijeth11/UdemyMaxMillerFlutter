import 'package:flutter/material.dart';
import 'package:grocia/constants/account-info.constants.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/pages/account_faq_page.dart';
import 'package:grocia/pages/info_detail_page.dart';
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
        return const InfoDetailPage(title:"Privacy");
      case TermsAndCondition:
        return const InfoDetailPage(title:"Terms & Conditions");
      case HelpAndSupport:
        const titles = [
          "How to check status of myy order",
          "Change items in my order",
          "Cancel my order",
          "Change my delivery address",
          "Help with a pick-up order",
          "My delivery person made me unsafe",
          "Refunding Payment",
        ];
        return Column(
          children: titles
              .map((title) => AccountOptionTile(
                  titleName: title,
                  leadingIcon: [],
                  onTap: () => {
                        Routemaster.of(context).push(
                            "${AccountScreen.routeName}/$HelpAndSupportDetail")
                      }))
              .toList(),
        );
      case HelpAndSupportDetail:
        return const InfoDetailPage(title:"Help & Support");
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
      case HelpAndSupport:
        return "Help & Support";
      case HelpAndSupportDetail:
        return "Help & Ticket";
      case Faq:
        return "FAQ";
      default:
        return "";
    }
  }
}

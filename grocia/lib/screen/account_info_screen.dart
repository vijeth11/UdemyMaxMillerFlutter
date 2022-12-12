import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocia/widgets/account_faq_page.dart';

class AccountInfoScreen extends StatelessWidget {
  final String infoType;
  const AccountInfoScreen({super.key, required this.infoType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(infoType),
      ),
      body: getInfoBody(),
    );
  }

  Widget getInfoBody() {
    switch (infoType) {
      case "FAQ":
        return AccountFAQPage();
      default:
        return Container();
    }
  }
}

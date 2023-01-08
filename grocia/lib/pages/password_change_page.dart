import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:grocia/widgets/save_changes_button.dart';

class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar("Change Password", context),
      body: Form(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...getInputForm(OLD_PASSWORD),
                  divider,
                  ...getInputForm(NEW_PASSWORD),
                  divider,
                  SaveChangesButton(onPress: () {
                    // need to implement changing of Password
                  })
                ],
              ))),
    );
  }
}

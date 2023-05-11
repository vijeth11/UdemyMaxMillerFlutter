import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/screen/getting_started_screen.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:routemaster/routemaster.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/SignUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackActionAppBar(context, ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's get started",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const Text("Create account to see our top picks for you"),
            const SizedBox(
              height: 15,
            ),
            ...getInputForm("Name"),
            divider,
            ...getInputForm("Phone number"),
            divider,
            ...getInputForm("Email"),
            divider,
            ...getInputForm("Password"),
            divider,
            ...getInputForm("Confirmation Password"),
            divider,
            SaveChangesButton(
              onPress: () => Routemaster.of(context)
                  .replace(GettingStartedScreen.routeName),
              title: "Create Account",
            )
          ],
        ),
      ),
    );
  }
}

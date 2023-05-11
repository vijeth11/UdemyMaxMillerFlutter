import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/screen/getting_started_screen.dart';
import 'package:grocia/screen/sign_up_screen.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:routemaster/routemaster.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/SignIn";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackActionAppBar(context, ''),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text("Sign in to Continue."),
              const SizedBox(
                height: 15,
              ),
              ...getInputForm("Enter Email"),
              divider,
              ...getInputForm("Enter Password"),
              divider,
              SaveChangesButton(
                onPress: () => Routemaster.of(context)
                    .replace(GettingStartedScreen.routeName),
                title: "Sign in",
              )
            ],
          ),
        ),
        bottomSheet: Container(
          height: 20,
          color: kWhiteColor,
          child: Center(
            child: TextButton(
              child: const Text("Don't have an account? Sign up"),
              onPressed: () =>
                  Routemaster.of(context).replace(SignUpScreen.routeName),
            ),
          ),
        ));
  }
}

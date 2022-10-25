import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_docs/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text('Sign in with Goolge', style: TextStyle(color: KBlackColor),),
          style: ElevatedButton.styleFrom(
              backgroundColor: kWhiteColor, minimumSize: const Size(150, 50)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/page_button.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback onPress;
  const AuthScreen({Key? key, required this.onPress}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool displaySignInPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              children: [
                const Image(
                  image: const AssetImage('assets/images/login.png'),
                ),
                Positioned.fill(
                  top: 265,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 30),
                      child: SingleChildScrollView(
                        child: displaySignInPage
                            ? getSiginPage()
                            : getSignupPage(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getTextInput(
      {int maxLines = 1,
      TextInputType type = TextInputType.text,
      bool obscureText = false,
      String initialValue = ""}) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: type,
      initialValue: initialValue,
      obscureText: obscureText,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget getSiginPage() {
    return Column(
      children: [
        getPageTitleHeader("Sign In"),
        const SizedBox(
          height: 20,
        ),
        getTextInput(
            type: TextInputType.emailAddress, initialValue: "info@example.com"),
        const SizedBox(
          height: 10,
        ),
        getTextInput(
            type: TextInputType.visiblePassword,
            initialValue: "test",
            obscureText: true),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.green.shade300, fontSize: 18),
            )),
        const SizedBox(
          height: 20,
        ),
        getPageButton("SIGN IN", widget.onPress),
        const SizedBox(
          height: 10,
        ),
        getPageButton("CREATE AN ACCOUNT", () {
          setState(() {
            displaySignInPage = false;
          });
        }),
      ],
    );
  }

  Widget getSignupPage() {
    double inputWidth = MediaQuery.of(context).size.width / 2 - 32;

    return Column(
      children: [
        getPageTitleHeader("Create your account"),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
                width: inputWidth, child: getTextInput(initialValue: "Smith")),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
                width: inputWidth, child: getTextInput(initialValue: "Jhons"))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        getTextInput(
            type: TextInputType.emailAddress, initialValue: "info@example.com"),
        const SizedBox(height: 10),
        getTextInput(
            type: TextInputType.visiblePassword,
            initialValue: "test",
            obscureText: true),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "By tapping Sign up you accept all terms and condition",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        getPageButton("CREATE AN ACCOUNT", widget.onPress),
      ],
    );
  }

  Widget getPageTitleHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              onPressed: () => setState(() {
                    displaySignInPage = true;
                  }),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )),
        )
      ],
    );
  }
}

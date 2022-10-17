import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:kedo_food/infrastructure/page_button.dart';
import 'package:kedo_food/providers/auth_provider.dart';

import '../helper/utils.dart';

enum AuthForms { signIn, signUp, forgotPassword }

class AuthScreen extends StatefulWidget {
  final Auth auth;
  const AuthScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AuthForms displaySignInPage = AuthForms.signIn;
  bool displayLoading = false;
  Map<String, String> _authData = {'email': '', 'passowrd': '', 'username': ''};
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _paswordController = TextEditingController();
  final _verificationCodeController = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0))
        .then((value) => _controller.forward());
    super.initState();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      displayLoading = true;
    });
    _formKey.currentState!.save();
    try {
      if (displaySignInPage == AuthForms.signIn) {
        await widget.auth.login(
            _authData['email'] as String, _authData['password'] as String);
      } else {
        await widget.auth.signup(_authData['email'] as String,
            _authData['password'] as String, _authData['username'] as String);
      }
    } on Exception catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      setState(() {
        displayLoading = false;
      });
    }
  }

  void resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          displayLoading = true;
        });
        await widget.auth.forgotPassword(
          _authData['email'] as String,
        );
        showAnimatedDialog(
            context: context,
            animationType: DialogTransitionType.slideFromLeftFade,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            builder: (ctx) {
              return SimpleDialog(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Enter the secret code sent to registered mail",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        getTextInput(controller: _verificationCodeController),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: const Text("Done"),
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green.shade500),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          alignment: Alignment.center),
                      onPressed: () async {
                        await submitPasswordResetCode(
                            _verificationCodeController.value.text);
                        Navigator.of(context).pop();
                        setState(() {
                          displayLoading = false;
                          displaySignInPage = AuthForms.signIn;
                        });
                        _controller.reset();
                        _controller.forward();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            "Password has been changed!!!!",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.green.shade200,
                        ));
                      },
                    ),
                  )
                ],
              );
            });
      } on HttpException catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        setState(() {
          displayLoading = false;
        });
      }
    }
  }

  Future<void> submitPasswordResetCode(String code) async {
    await widget.auth.passwordReset(
        _authData['email'] as String, _authData['password'] as String, code);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
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
                SizedBox(
                    width: double.infinity,
                    height: screenHeight / 2,
                    child: const Image(
                      image: AssetImage('assets/images/login.png'),
                      fit: BoxFit.cover,
                    )),
                Positioned.fill(
                  top: screenHeight / 2 - 100,
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
                        child: displaySignInPage == AuthForms.signIn
                            ? SlideTransition(
                                position: _offsetAnimation,
                                child: getSiginPage())
                            : displaySignInPage == AuthForms.forgotPassword
                                ? SlideTransition(
                                    position: _offsetAnimation,
                                    child: getForgotPasswordPage())
                                : SlideTransition(
                                    position: _offsetAnimation,
                                    child: getSignupPage()),
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

  Widget getSiginPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          getPageTitleHeader("Sign In", displayCrossIcon: false),
          const SizedBox(
            height: 20,
          ),
          getTextInput(
              type: TextInputType.emailAddress,
              saved: (value) {
                _authData['email'] = value ?? '';
              }),
          const SizedBox(
            height: 10,
          ),
          getTextInput(
              type: TextInputType.visiblePassword,
              obscureText: true,
              saved: (value) {
                _authData['password'] = value ?? '';
              }),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  displaySignInPage = AuthForms.forgotPassword;
                });
                _controller.reset();
                _controller.forward();
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.green.shade300, fontSize: 18),
              )),
          const SizedBox(
            height: 20,
          ),
          if (!displayLoading)
            getPageButton("SIGN IN", _submit)
          else
            const Center(
              child: const CircularProgressIndicator(),
            ),
          const SizedBox(
            height: 10,
          ),
          getPageButton("CREATE AN ACCOUNT", () {
            setState(() {
              displaySignInPage = AuthForms.signUp;
            });
            _controller.reset();
            _controller.forward();
          }),
        ],
      ),
    );
  }

  Widget getSignupPage() {
    double inputWidth = MediaQuery.of(context).size.width / 2 - 32;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          getPageTitleHeader("Create your account"),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                  width: inputWidth,
                  child: getTextInput(saved: (value) {
                    _authData['username'] = value ?? '';
                  })),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  width: inputWidth,
                  child: getTextInput(saved: (value) {
                    _authData['username'] =
                        '${_authData['username']!} ${value ?? ''}';
                  }))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          getTextInput(
              type: TextInputType.emailAddress,
              saved: (value) {
                _authData['email'] = value ?? '';
              }),
          const SizedBox(height: 10),
          getTextInput(
              type: TextInputType.visiblePassword,
              obscureText: true,
              saved: (value) {
                _authData['password'] = value ?? '';
              }),
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
          if (!displayLoading)
            getPageButton("CREATE AN ACCOUNT", _submit)
          else
            const Center(
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget getForgotPasswordPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          getPageTitleHeader("Forgot Password", displayCrossIcon: true),
          const SizedBox(
            height: 20,
          ),
          getTextInput(
              type: TextInputType.emailAddress,
              placeHolder: "Email Address",
              saved: (value) {
                _authData['email'] = value ?? '';
              }),
          const SizedBox(
            height: 10,
          ),
          getTextInput(
            type: TextInputType.visiblePassword,
            obscureText: true,
            placeHolder: "Password",
            controller: _paswordController,
          ),
          const SizedBox(
            height: 20,
          ),
          getTextInput(
              type: TextInputType.visiblePassword,
              obscureText: true,
              validate: (value) {
                if (value != _paswordController.value.text) {
                  return "Password is not correct";
                }
                return null;
              },
              placeHolder: "Confirm Password",
              saved: (value) {
                _authData['password'] = value ?? '';
              }),
          const SizedBox(
            height: 20,
          ),
          if (!displayLoading)
            getPageButton("Reset Password", resetPassword)
          else
            const Center(
              child: const CircularProgressIndicator(),
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget getPageTitleHeader(String title, {bool displayCrossIcon = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        if (displayCrossIcon)
          SizedBox(
            height: 35,
            width: 35,
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  setState(() {
                    displaySignInPage = AuthForms.signIn;
                  });
                  _controller.reset();
                  _controller.forward();
                },
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

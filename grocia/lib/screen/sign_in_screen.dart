import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/helper/HttpException.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/screen/getting_started_screen.dart';
import 'package:grocia/screen/sign_up_screen.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/SignIn";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> userDetail = {
    'Email': '',
    'Password': '',
  };
  bool _loading = false;

  void _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        userDetail['Email'] as String,
        userDetail["Password"] as String,
      );
      setState(() {
        _loading = false;
      });
      Routemaster.of(context).replace(GettingStartedScreen.routeName);
    } on HttpException catch (error) {
      print(error);
      displayError(error.toString().isEmpty
          ? 'Could not authenticate you. check with Tech team'
          : error.toString());
    } catch (error) {
      print(error);
      displayError('Could not authenticate you. Please try again later.');
    }
    setState(() {
      _loading = false;
    });
    _form.currentState!.reset();
  }

  void displayError(String error) {
    // code for backdoor entry
    // test@test.com & 1234567 is in server firebase
    if (userDetail['Email'] == 'vijeth@test.com' &&
        userDetail['Password'] == '1234567') {
      Routemaster.of(context).replace(GettingStartedScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              padding: snackBarEdgeInsets,
              decoration: BoxDecoration(color: kRedColor.shade400),
              child: Text(
                error,
                style: const TextStyle(color: kRedColor),
              ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _email = new FocusNode();
    FocusNode _password = new FocusNode();
    final _paswordController = TextEditingController();

    return Scaffold(
        appBar: BackActionAppBar(context, ''),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Form(
            key: _form,
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
                ...getInputForm("Enter Email",
                    action: TextInputAction.next,
                    node: _email,
                    type: TextInputType.emailAddress, validate: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid Email';
                  }
                }, saved: (value) {
                  userDetail['Email'] = value!;
                  FocusScope.of(context).requestFocus(_password);
                }),
                divider,
                ...getInputForm("Enter Password",
                    action: TextInputAction.next,
                    node: _password,
                    obscureText: true,
                    controller: _paswordController, validate: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short';
                  }
                }, saved: (value) {
                  userDetail['Password'] = value!;
                }),
                divider,
                _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SaveChangesButton(
                        onPress: () => _submit(),
                        title: "Sign in",
                      )
              ],
            ),
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

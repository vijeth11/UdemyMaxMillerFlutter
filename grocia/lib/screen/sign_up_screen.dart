import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/helper/HttpException.dart';
import 'package:grocia/helper/TextMasking.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/screen/getting_started_screen.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/SignUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> userDetail = {
    'Name': '',
    'Phone': '',
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
      await Provider.of<AuthProvider>(context, listen: false).signup(
          userDetail['Email'] as String,
          userDetail["Password"] as String,
          userDetail['Name'] as String,
          userDetail['Phone'] as String);
      setState(() {
        _loading = false;
      });
      Routemaster.of(context).replace(GettingStartedScreen.routeName);
    } on HttpException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              padding: snackBarEdgeInsets,
              decoration: BoxDecoration(color: kRedColor.shade400),
              child: Text(
                error.toString(),
                style: const TextStyle(color: kRedColor),
              ))));
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
        padding: snackBarEdgeInsets,
        decoration: BoxDecoration(color: kRedColor.shade400),
        child:
            const Text('Could not authenticate you. Please try again later.'),
      )));
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _phone = new FocusNode();
    FocusNode _email = new FocusNode();
    FocusNode _password = new FocusNode();
    FocusNode _confirmPassword = new FocusNode();
    final _paswordController = TextEditingController();
    return Scaffold(
      appBar: BackActionAppBar(context, ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
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
                ...getInputForm(
                  "Name",
                  action: TextInputAction.next,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Name";
                    }
                  },
                  saved: (value) {
                    userDetail['Name'] = value!;
                    FocusScope.of(context).requestFocus(_phone);
                  },
                ),
                divider,
                ...getInputForm("Phone number",
                    action: TextInputAction.next,
                    node: _phone,
                    textFormatter: [TextMasking("(xxx) xxxx-xxxx")],
                    validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Phone number";
                  }
                  if (!value
                      .toString()
                      .contains(RegExp(r'\([0-9]{3}\) [0-9]{4}-[0-9]{4}'))) {
                    return "phone number format (000) 0000-0000";
                  }
                }, saved: (value) {
                  userDetail['Phone'] = value!.replaceAll(' ', '');
                  FocusScope.of(context).requestFocus(_email);
                }),
                divider,
                ...getInputForm("Email",
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
                ...getInputForm("Password",
                    action: TextInputAction.next,
                    node: _password,
                    obscureText: true,
                    controller: _paswordController, validate: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short';
                  }
                }, saved: (value) {
                  userDetail['Password'] = value!;
                  FocusScope.of(context).requestFocus(_confirmPassword);
                }),
                divider,
                ...getInputForm("Confirmation Password",
                    action: TextInputAction.done,
                    node: _confirmPassword,
                    obscureText: true, validate: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short';
                  }
                  if (value != _paswordController.text) {
                    return 'Passwords do not match';
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
                        title: "Create Account",
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

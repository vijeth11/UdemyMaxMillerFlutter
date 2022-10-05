import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/page_button.dart';

class AuthScreen extends StatefulWidget {
  final Function(bool isSignup, String email, String password,
      {String username}) onPress;
  const AuthScreen({Key? key, required this.onPress}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool displaySignInPage = true;
  bool displayLoading = false;
  Map<String, String> _authData = {'email': '', 'passowrd': '', 'username': ''};
  final GlobalKey<FormState> _formKey = GlobalKey();
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

  void _submit() async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      displayLoading = true;
    });
    _formKey.currentState!.save();
    if (displaySignInPage) {
      await widget.onPress(displaySignInPage, _authData['email'] as String,
          _authData['password'] as String);
    } else {
      await widget.onPress(displaySignInPage, _authData['email'] as String,
          _authData['password'] as String,
          username: _authData['username'] as String);
    }
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
                      image: const AssetImage('assets/images/login.png'),
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
                        child: displaySignInPage
                            ? SlideTransition(
                                position: _offsetAnimation,
                                child: getSiginPage())
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

  Widget getTextInput(
      {int maxLines = 1,
      TextInputType type = TextInputType.text,
      bool obscureText = false,
      Function(String?)? saved,
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
      onSaved: saved,
    );
  }

  Widget getSiginPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          getPageTitleHeader("Sign In"),
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
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.green.shade300, fontSize: 18),
              )),
          const SizedBox(
            height: 20,
          ),
          if(!displayLoading)
          getPageButton("SIGN IN", _submit)
          else
          Center(child: CircularProgressIndicator(),),
          const SizedBox(
            height: 10,
          ),
          getPageButton("CREATE AN ACCOUNT", () {
            setState(() {
              displaySignInPage = false;
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
          if(!displayLoading)
          getPageButton("CREATE AN ACCOUNT", _submit)
          else
          Center(child: CircularProgressIndicator(),),
        ],
      ),
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
              onPressed: () {
                setState(() {
                  displaySignInPage = true;
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

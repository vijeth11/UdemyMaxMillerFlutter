import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function(
    String email,
    String password,
    String username,
    File? userImage,
    bool isLogin,
  ) submitAuthForm;
  final bool isLoading;
  const AuthForm(this.submitAuthForm, this.isLoading, {Key? key})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPAssword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final valid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (valid) {
      _formKey.currentState?.save();
      widget.submitAuthForm(_userEmail.trim(), _userPAssword.trim(),
          _userName.trim(), _userImageFile, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(imagepickfn: _pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@"))
                          return "Please enter a valid Email";
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value ?? '';
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                          key: ValueKey('username'),
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return "Userbname should be minimum 4 characters";
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value ?? '';
                          }),
                    TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7)
                            return "Password should be at least 7 chareacters long";
                          return null;
                        },
                        onSaved: (value) {
                          _userPAssword = value ?? '';
                        }),
                    SizedBox(height: 12),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? ' Login ' : ' Signup '),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20))))),
                    if (!widget.isLoading)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'I already have an account'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

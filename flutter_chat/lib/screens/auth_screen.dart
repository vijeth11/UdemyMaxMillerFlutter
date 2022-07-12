import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final authInstance = FirebaseAuth.instance;
  Future<void> _submitAuthForm(String email, String password, String userName,
      File? userImage, bool isLogin) async {
    UserCredential authresult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authresult = await authInstance.signInWithEmailAndPassword(
            email: email, password: password);
        _displayMessageInSnackBar("logged in successfully");
      } else {
        authresult = await authInstance.createUserWithEmailAndPassword(
            email: email, password: password);
        var ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authresult.user!.uid + '.jpg');
        await ref.putFile(userImage!).whenComplete(() => null);
        var imagerUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user!.uid)
            .set(
                {'username': userName, 'email': email, 'userimage': imagerUrl});
        _displayMessageInSnackBar("created user successfully");
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      var message = 'An error occured, please check your credentials!';
      if (error.message != null) {
        message = error.message ?? '';
      }
      setState(() {
        _isLoading = false;
      });
      _displayMessageInSnackBar(message, isError: true);
    } catch (error) {
      print(error);
    }
  }

  void _displayMessageInSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor:
          isError ? Theme.of(context).errorColor : Colors.green.shade700,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/auth_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var fbApp = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    var theme = ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))));
    return MaterialApp(
      title: 'Flutter Chat',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.deepPurple, brightness: Brightness.dark)),
      home: FutureBuilder(
          future: fbApp,
          builder: (ctx, snapShot) =>
              snapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : AuthScreen()),
    );
  }
}

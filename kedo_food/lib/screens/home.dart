import 'package:flutter/material.dart';
import 'package:kedo_food/widgets/bottom_navigator.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Start"),
      ),
      bottomNavigationBar: BottomNavigator(BottomIcons.Home),
    );
  }
}

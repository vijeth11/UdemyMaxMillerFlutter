import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account';
  static const int iconIndex = 3;
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Account Screen'),
      ),
      bottomNavigationBar: BottomNavigation(activeItemIndex: iconIndex),
    );
  }
}

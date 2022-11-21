import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/shop';
static const int iconIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),

      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}

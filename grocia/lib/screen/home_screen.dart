import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/shop';
static const int iconIndex = 0;

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),

      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}

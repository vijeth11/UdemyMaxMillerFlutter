import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order';
  static const int iconIndex = 2;
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Order Screen"),
      ),
      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}

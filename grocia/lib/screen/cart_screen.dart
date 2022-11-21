import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  static const int iconIndex = 1;
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cart Screen'),
      ),
      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}

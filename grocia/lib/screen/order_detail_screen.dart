import 'package:flutter/material.dart';
import 'package:grocia/widgets/bottom_navigator.dart';

class OrderDetailScreen extends StatelessWidget {
  final String OrderId;
  static const int iconIndex = 2;

  const OrderDetailScreen({super.key, required this.OrderId});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: Text("Test the data"),
      ),
      bottomNavigationBar: BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}

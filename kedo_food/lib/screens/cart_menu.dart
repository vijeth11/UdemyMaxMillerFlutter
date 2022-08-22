import 'package:flutter/material.dart';
import 'package:kedo_food/widgets/bottom_navigator.dart';

class CartMenu extends StatefulWidget {
  static const String routeName = 'CartMenu';
  const CartMenu({Key? key}) : super(key: key);

  @override
  State<CartMenu> createState() => _CartMenuState();
}

class _CartMenuState extends State<CartMenu> {
  final double leftRightPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: leftRightPadding, right: leftRightPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shopping Cart'),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: Colors.green.shade200),
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: leftRightPadding, right: leftRightPadding),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigator(BottomIcons.Cart),
    );
  }
}

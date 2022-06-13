import 'package:flutter/material.dart';
import 'package:my_shop/screens/order_screen.dart';

class MainDrawer extends StatelessWidget {
  final double appBarHeight;
  const MainDrawer({Key? key, required this.appBarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        SizedBox(
          height: appBarHeight - 5,
        ),
        Container(
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: const Text(
            'Hello Friend!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const Divider(),
        ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: const Icon(Icons.shop),
            title: const Text('Shop')),
        const Divider(),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
            leading: const Icon(Icons.payment),
            title: const Text('Orders'))
      ],
    ));
  }
}

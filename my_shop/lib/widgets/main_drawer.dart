import 'package:flutter/material.dart';
import 'package:my_shop/helpers/custom_route.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:my_shop/screens/order_screen.dart';
import 'package:my_shop/screens/products_overview_screen.dart';
import 'package:my_shop/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

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
              // This is another way of providing an custom animation for a particular page
              // this is currently commented out as main.dart file has same anuimation for all pages. 
              //Navigator.of(context).pushReplacement(CustomRoute(builder:(ctx)=> OrderScreen()));
            },
            leading: const Icon(Icons.payment),
            title: const Text('Orders')),
        const Divider(),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
            },
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products')),
        const Divider(),
        ListTile(
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'))
      ],
    ));
  }
}

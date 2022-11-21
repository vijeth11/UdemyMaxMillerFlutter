import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/screen/account_screen.dart';
import 'package:grocia/screen/cart_screen.dart';
import 'package:grocia/screen/home_screen.dart';
import 'package:grocia/screen/order_screen.dart';
import 'package:routemaster/routemaster.dart';

class BottomNavigation extends StatelessWidget {
  final int activeItemIndex;
  const BottomNavigation({Key? key, required this.activeItemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: kGreenColor,
      selectedLabelStyle: const TextStyle(color: kGreenColor),
      unselectedItemColor: kGreyColor,
      unselectedLabelStyle: const TextStyle(color: kGreyColor),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: activeItemIndex,
      items: [
        getRowButton('Shop', Icons.shopping_bag_rounded),
        getRowButton('Cart', Icons.shopping_cart),
        getRowButton('My Order', Icons.fact_check),
        getRowButton('Account', Icons.person)
      ],
      onTap: (index) {
        String route = '';
        switch (index) {
          case HomeScreen.iconIndex:
            route = HomeScreen.routeName;
            break;
          case CartScreen.iconIndex:
            route = CartScreen.routeName;
            break;
          case OrderScreen.iconIndex:
            route = OrderScreen.routeName;
            break;
          case AccountScreen.iconIndex:
            route = AccountScreen.routeName;
            break;
        }
        Routemaster.of(context).replace(route);
      },
    );
  }

  BottomNavigationBarItem getRowButton(String name, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: name,
    );
  }
}

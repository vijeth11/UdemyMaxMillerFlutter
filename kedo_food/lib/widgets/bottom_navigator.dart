import 'package:flutter/material.dart';
import 'package:kedo_food/screens/cart_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/wish_list.dart';

enum BottomIcons { Home, Categories, Cart, Favorite, Profile }

class BottomNavigator extends StatelessWidget {
  final BottomIcons active;
  const BottomNavigator(this.active, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: Icon(Icons.home,
                color: active == BottomIcons.Home ? Colors.green : Colors.grey),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.sync_alt,
                color: active == BottomIcons.Categories
                    ? Colors.green
                    : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(CategoryTypeList.routeName);
            }),
        IconButton(
            icon: Icon(Icons.shopping_cart_rounded,
                color: active == BottomIcons.Cart ? Colors.green : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(CartMenu.routeName);
            }),
        IconButton(
            icon: Icon(Icons.favorite,
                color: active == BottomIcons.Favorite
                    ? Colors.green
                    : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(WishList.routeName);
            }),
        IconButton(
            icon: Icon(Icons.account_circle_sharp,
                color:
                    active == BottomIcons.Profile ? Colors.green : Colors.grey),
            onPressed: () {}),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kedo_food/screens/cart_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/user_profile_options.dart';
import 'package:kedo_food/screens/wish_list.dart';

enum BottomIcons { Home, Categories, Cart, Favorite, Profile }

class BottomNavigator extends StatelessWidget {
  final BottomIcons active;
  final double iconSize = 35;
  const BottomNavigator(this.active, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: Icon(Icons.home,
                size: iconSize,
                color: active == BottomIcons.Home ? Colors.green : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(MyHomePage .routeName);
            }),
        IconButton(
            icon: Icon(Icons.sync_alt,
                size: iconSize,
                color: active == BottomIcons.Categories
                    ? Colors.green
                    : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(CategoryTypeList.routeName);
            }),
        IconButton(
            icon: Icon(Icons.shopping_cart_rounded,
                size: iconSize,
                color: active == BottomIcons.Cart ? Colors.green : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(CartMenu.routeName);
            }),
        IconButton(
            icon: Icon(Icons.favorite,
                size: iconSize,
                color: active == BottomIcons.Favorite
                    ? Colors.green
                    : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(WishList.routeName);
            }),
        IconButton(
            icon: Icon(Icons.account_circle_sharp,
                size: iconSize,
                color:
                    active == BottomIcons.Profile ? Colors.green : Colors.grey),
            onPressed: () {
              Navigator.of(context).pushNamed(UserProfileOption.routeName);
            }),
      ],
    );
  }
}

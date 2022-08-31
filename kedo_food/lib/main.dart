import 'package:flutter/material.dart';
import 'package:kedo_food/screens/cart_menu.dart';
import 'package:kedo_food/screens/category_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/item_detail.dart';
import 'package:kedo_food/screens/message_bot.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/screens/order_detail_screen.dart';
import 'package:kedo_food/screens/user_profile.dart';
import 'package:kedo_food/screens/user_profile_options.dart';
import 'package:kedo_food/screens/wish_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kedo Food',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      routes: {
        MyHomePage.routeName: (context) => MyHomePage(),
        CategoryTypeList.routeName: (context) => CategoryTypeList(),
        CategoryMenu.routeName: (context) => CategoryMenu(),
        ItemDetail.routeName: (context) => ItemDetail(),
        CartMenu.routeName: (context) => CartMenu(),
        WishList.routeName: (context) => WishList(),
        UserProfileOption.routeName: (context) => UserProfileOption(),
        UserProfile.routeName: (context) => UserProfile(),
        MyOrders.routeName: (context) => MyOrders(),
        OrderDetailScreen.routeName :(context) => OrderDetailScreen(),
        MessageBot.routeName:(context) => MessageBot()
      },
    );
  }
}

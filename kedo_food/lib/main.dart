import 'package:flutter/material.dart';
import 'package:kedo_food/screens/category_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/home.dart';
import 'package:kedo_food/screens/item_detail.dart';

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
      },
    );
  }
}

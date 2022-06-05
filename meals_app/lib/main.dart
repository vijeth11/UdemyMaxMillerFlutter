import 'package:flutter/material.dart';
import 'package:meals_app/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            titleMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed')));
    return MaterialApp(
      title: 'DeliMeals',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber)),
      home: CategoriesScreen(),
    );
  }
}

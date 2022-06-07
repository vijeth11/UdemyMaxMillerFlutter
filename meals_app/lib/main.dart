import 'package:flutter/material.dart';
import 'package:meals_app/screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, bool> settings = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  void setSettings(Map<String, bool> newSettings) {
    setState(() {
      settings = newSettings;
    });
  }

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
      //home: CategoriesScreen(), //landing screen of the app else uses routes default '/' value
      initialRoute:
          '/', // default '/' but it can be changed using this attribute
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealSecreen.routeName: (ctx) => CategoryMealSecreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(
              setSelectedSettings: setSettings,
            ),
      },
      onGenerateRoute: (settings) {
        // this is called when there is no route defined for the name in routes attribute
        // otherwise it is not called at all here you can define switch case routes or default route
        // currently this project does notr require this
        print(settings);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // this is a fallback page like 404 page in web
        // this executes if onGenerateRoute is not defined as above
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

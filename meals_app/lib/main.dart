import 'package:flutter/material.dart';
import './data/dummy_data.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

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

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favourites = [];

  void setSettings(Map<String, bool> newSettings) {
    setState(() {
      settings = newSettings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (settings['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (settings['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (settings['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (settings['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourite(String mealId) {
    setState(() {
      final int existingIndex =
          _favourites.indexWhere((element) => element.id == mealId);
      if (existingIndex > -1) {
        _favourites.removeAt(existingIndex);
      } else {
        _favourites
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    });
  }

  bool isMealFavourite(String id) {
    return _favourites.any((element) => element.id == id);
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
        '/': (ctx) => TabsScreen(favouriteMeals: _favourites),
        CategoryMealSecreen.routeName: (ctx) => CategoryMealSecreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            isMealFavourite: isMealFavourite,
            addOrRemoveFavourite: toggleFavourite),
        SettingsScreen.routeName: (ctx) => SettingsScreen(
              settings: settings,
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

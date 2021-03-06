import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealSecreen extends StatefulWidget {
  static const String routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealSecreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealSecreen> createState() => _CategoryMealSecreenState();
}

class _CategoryMealSecreenState extends State<CategoryMealSecreen> {
  List<String> excludeMealItemIds = [];
  void deleteTheMealItem(String mealId) {
    setState(() {
      this.excludeMealItemIds.add(mealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String categoryTitle = routeData['title'] as String;
    final String categoryId = routeData['id'] as String;
    final List<Meal> categoryMeals = widget.availableMeals
        .where((meal) =>
            meal.categories.contains(categoryId) &&
            !excludeMealItemIds.contains(meal.id))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(categoryMeals[index]);
          },
          itemCount: categoryMeals.length,
        ));
  }
}

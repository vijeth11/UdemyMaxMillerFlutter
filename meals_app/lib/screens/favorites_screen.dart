import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favourites;
  const FavoritesScreen({Key? key, required this.favourites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(favourites[index]);
        },
        itemCount: favourites.length,
      );
    }
  }
}

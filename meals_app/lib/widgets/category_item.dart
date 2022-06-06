import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  CategoryItem(this.item);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealSecreen.routeName,
        arguments: {'id': item.id, 'title': item.title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        decoration: BoxDecoration(
            color: item.color,
            gradient: LinearGradient(
                colors: [item.color.withOpacity(0.7), item.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

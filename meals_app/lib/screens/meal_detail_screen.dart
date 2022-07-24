import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal_detail';
  final Function addOrRemoveFavourite;
  final Function(String) isMealFavourite;

  const MealDetailScreen(
      {super.key,
      required this.addOrRemoveFavourite,
      required this.isMealFavourite});

  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)?.settings.arguments as Map<String, Meal>;
    final Meal currentItem = routeData['currentItem'] as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentItem.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                currentItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
                ListView(
                  children: [
                    ...currentItem.ingredients
                        .map((ingredient) => Card(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(ingredient))))
                        .toList()
                  ],
                ),
                context),
            buildSectionTitle('Steps', context),
            buildContainer(
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(children: [
                      ListTile(
                        leading: CircleAvatar(
                            child: Text(
                          '#${index + 1}',
                        )),
                        title: Text(currentItem.steps[index]),
                      ),
                      Divider(
                        thickness: 2,
                      )
                    ]);
                  },
                  itemCount: currentItem.steps.length,
                ),
                context)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isMealFavourite(currentItem.id) ? Icons.star : Icons.star_border),
        onPressed: () {
          addOrRemoveFavourite(currentItem.id);
        },
      ),
    );
  }
}

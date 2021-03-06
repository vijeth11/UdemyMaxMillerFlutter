import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  const TabsScreen({super.key, required this.favouriteMeals});

  @override
  State<StatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages = [];
  int selectedPageIndex = 0;
  void selectPage(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {'page': CategoriesScreen(), 'title': 'DeliMeals'},
      {
        'page': FavoritesScreen(
          favourites: widget.favouriteMeals,
        ),
        'title': 'Your Favorites'
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(pages[selectedPageIndex]['title'] as String),
    );
    return Scaffold(
      appBar: appBar,
      drawer: MainDrawer(appBar.preferredSize.height),
      body: pages[selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorites')
        ],
        onTap: selectPage,
      ),
    );
  }
}

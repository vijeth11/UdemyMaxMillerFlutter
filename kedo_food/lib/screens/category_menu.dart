import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';
import 'package:kedo_food/model/category_tile_detail.dart';
import 'package:kedo_food/providers/products.dart';
import 'package:kedo_food/widgets/expandable_appbar.dart';
import 'package:kedo_food/widgets/item_card_grid_display.dart';
import 'package:provider/provider.dart';

import 'category_type_list.dart';

class CategoryMenu extends StatefulWidget {
  static const String routeName = 'CategoryName';

  CategoryMenu({Key? key}) : super(key: key);

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  late TileDetail _categoryTile;

  @override
  Widget build(BuildContext context) {
    _categoryTile = ModalRoute.of(context)!.settings.arguments as TileDetail;
    var marketItem = Provider.of<Products>(context)
        .items
        .where((element) => element.categoryName == _categoryTile.title)
        .toList();
    return ExpandableAppBar(
      displaySearchBar: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(CategoryTypeList.routeName);
              },
              icon: const Icon(
                Icons.menu_rounded,
                size: 40,
              )),
        )
      ],
      leading: AppBackButton(context),
      collapsedTitle: Text(
        _categoryTile.title,
        style: const TextStyle(color: Colors.black),
      ),
      expandedTitle: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_categoryTile.title, style: const TextStyle(fontSize: 25)),
          Text(
            '${marketItem.length} items',
            style: TextStyle(fontSize: 15),
          )
        ]),
      ),
      expandedTitleBackground: Container(
        color: Color(0xFF4CB32B),
      ),
      // market ietm cards
      appBody: ItemCardsGridDisplay(
        menuItems: marketItem,
      ),
    );
  }
}

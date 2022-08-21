import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/model/tile_detail.dart';
import 'package:kedo_food/screens/item_detail.dart';
import 'package:kedo_food/widgets/expandable_appbar.dart';
import 'package:kedo_food/widgets/item_card.dart';

import 'category_type_list.dart';

class CategoryMenu extends StatefulWidget {
  static const String routeName = 'CategoryName';

  CategoryMenu({Key? key}) : super(key: key);

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  late List<MarketItem> menuItems = List.generate(
      20,
      (index) => MarketItem(
              name: 'Avocado',
              cost: 8.8,
              isFavourite: true,
              image: 'item-brocoli.png',
              rating: 4.5,
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                  'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
                  ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                  'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
              discussion:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                  'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
                  ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                  'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
              reviews: [
                Review(
                    name: 'Jhon Leo',
                    review:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                    rating: 4,
                    date: DateTime.now(),
                    image: 'assets/images/user1.png'),
                Review(
                    name: 'Logan Tucker',
                    review:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                    rating: 4,
                    date: DateTime.now(),
                    image: 'assets/images/user2.png'),
                Review(
                    name: 'Jasmine James',
                    review:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                    rating: 4,
                    date: DateTime.now(),
                    image: 'assets/images/user3.png')
              ]));
  late TileDetail _categoryTile;

  @override
  Widget build(BuildContext context) {
    _categoryTile = ModalRoute.of(context)!.settings.arguments as TileDetail;
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
            '${_categoryTile.itemCount} items',
            style: TextStyle(fontSize: 15),
          )
        ]),
      ),
      expandedTitleBackground: Container(
        color: Color(0xFF4CB32B),
      ),
      appBody: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ItemCard(
              item: menuItems[index],
              isCardLeft: (index % 2) == 0,
              onClick: () {
                Navigator.of(context).pushNamed(ItemDetail.routeName,
                    arguments: menuItems[index]);
              },
            );
          }, childCount: menuItems.length),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 250,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5)),
    );
  }
}

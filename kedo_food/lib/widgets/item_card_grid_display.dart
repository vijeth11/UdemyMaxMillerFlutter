import 'package:flutter/cupertino.dart';
import 'package:kedo_food/model/market_item.dart';

import '../screens/item_detail.dart';
import 'item_card.dart';

class ItemCardsGridDisplay extends StatelessWidget {
  final List<MarketItem> menuItems;

  const ItemCardsGridDisplay({super.key, required this.menuItems});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ItemCard(
            item: menuItems[index],
            isCardLeft: (index % 2) == 0,
            onClick: () {
              Navigator.of(context)
                  .pushNamed(ItemDetail.routeName, arguments: menuItems[index]);
            },
          );
        }, childCount: menuItems.length),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5));
  }
}

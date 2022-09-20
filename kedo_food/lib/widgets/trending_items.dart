import 'package:flutter/material.dart';
import 'package:kedo_food/providers/products.dart';
import 'package:kedo_food/screens/item_detail.dart';
import 'package:kedo_food/widgets/item_card.dart';
import 'package:provider/provider.dart';

class TrendingItems extends StatelessWidget {
  const TrendingItems({
    Key? key,
    required this.heightOfGridRow,
  }) : super(key: key);

  final int heightOfGridRow;

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, value, child) {
        List items = value.trendingItems();
        return SizedBox(
            height: (heightOfGridRow * items.length).toDouble(),
            child: GridView.builder(
              //suppress the inner gridview scroller and allow page scroll
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              padding: const EdgeInsets.only(top: 0),
              itemBuilder: (context, index) {
                return ItemCard(
                  item: items[index],
                  isCardLeft: (index % 2) == 0,
                  onClick: () {
                    Navigator.of(context).pushNamed(ItemDetail.routeName,
                        arguments: items[index]);
                  },
                );
              },
            ));
      },
    );
  }
}

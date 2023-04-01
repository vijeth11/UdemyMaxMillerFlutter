import 'package:flutter/material.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/widgets/product_item_card.dart';

Widget getProductItemsGrid(List<ItemModel> items, {double sizedHeight = 748}) {
  const childCardWidthPercent = 100.0;
  const childCardHeightPercent = 125.0;
  return SizedBox(
    height: sizedHeight,
    child: GridView.count(
        childAspectRatio: (childCardWidthPercent / childCardHeightPercent),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children:
            items.map((item) => ProductItemCard(productItem: item)).toList()),
  );
}

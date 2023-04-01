import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/product-item-grid.dart';
import 'package:provider/provider.dart';

class CategoryItemScreen extends StatelessWidget {
  static const String routeName = '/category-items';
  final String title;

  CategoryItemScreen(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var items = Provider.of<ProductItemProvider>(context, listen: false)
        .itemsByCategory(title);
    double sizedHeight = items.isNotEmpty
        ? ((items.length % 2) == 0 ? items.length : items.length + 1) / 2 * 260
        : 0;
    return Scaffold(
      appBar: BackActionAppBar(context, title),
      body: items.isNotEmpty
          ? SingleChildScrollView(
              child: getProductItemsGrid(items, sizedHeight: sizedHeight))
          : const Center(
              child: Text(
                "No items available in this category yet.",
                style: TextStyle(color: kGreyLightColor),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid({
    Key? key,
    required this.showFavs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this is a providers listener which takes an type of class defined in
    // create attribute of ChangeNotifierProvider object
    final productsListener = Provider.of<Products>(context);
    final List<Product> loadedProducts =
        showFavs ? productsListener.favouriteItems : productsListener.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) {
          // we use value instead of creat bulilder because we need provider attach
          // to data not the context so that with hidden items in the grid view which
          // goes beyond the screen does not throw error and we only want to watch change in data
          // if you are using provider.value constructor we need to dispose the data set to value
          // attribute whenever this page is exited from visibility otherwise it will cause memory leaks
          // currently ChangeNotifierProvider is disposing the data
          return ChangeNotifierProvider.value(
              value: loadedProducts[i], child: ProductItem());
        });
  }
}

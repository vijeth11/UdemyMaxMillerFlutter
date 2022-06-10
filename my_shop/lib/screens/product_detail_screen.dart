import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    // if listen is set to false any change on items in Products will not be listened
    // by default listen is true in Provider
    final productsProvider = Provider.of<Products>(context, listen: false);
    final Product item = productsProvider.findById(productId as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user-products';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productListner = Provider.of<Products>(context);
    final appBar = AppBar(
      title: const Text('Your Products'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ],
    );

    return Scaffold(
        appBar: appBar,
        drawer: MainDrawer(
          appBarHeight: appBar.preferredSize.height,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              var product = productListner.items[index];
              // you dont need to wrap ListTile widget with card you if error is thrown it
              // can because of the intenal child widget of ListTile pls check first error message
              return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: UserProductItem(
                      id: product.id,
                      title: product.title,
                      imageUrl: product.imageUrl));
            },
            itemCount: productListner.items.length,
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import '../providers/cart.dart';
import '../widgets/display_error.dart';
import './cart_screen.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  static const String routeName = '/';
  ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  bool _showOnlyFavourites = false;
  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((value) => setState(() => isLoading = false))
        .catchError((error) {
      print(error);
      displayError(
          error,
          context,
          () => setState(() {
                isLoading = false;
              }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appbar = AppBar(
      title: const Text('MyShop'),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: FilterOptions.Favourites,
              child: Text('Only Favorites'),
            ),
            const PopupMenuItem(
              value: FilterOptions.All,
              child: Text('Show all'),
            ),
          ],
          icon: const Icon(Icons.more_vert),
          onSelected: (FilterOptions SelectedValue) {
            setState(() {
              if (SelectedValue == FilterOptions.Favourites) {
                _showOnlyFavourites = true;
              } else {
                _showOnlyFavourites = false;
              }
            });
          },
        ),
        Consumer<Cart>(
            builder: (ctx, value, child) => Badge(
                value: value.itemCount.toString(),
                child: child ?? const SizedBox()),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ))
      ],
    );

    return Scaffold(
        appBar: appbar,
        drawer: MainDrawer(
          appBarHeight: appbar.preferredSize.height,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(showFavs: _showOnlyFavourites));
  }
}

import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartListner = Provider.of<Cart>(context, listen: false);
    // clipRect sets a border radius
    //final product = Provider.of<Product>(context);
    // Consumer is an alternative to Provider.of it listens always
    // we can use this with Provider if we want only one child widget to keep
    // listening but others only need one time data.
    // for this you wrap the child widget which requires changes with Consumer and
    // set listen attribute of Provider.of as false
    return Consumer<Product>(
      builder: (ctxt, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                  product.favourite ? Icons.favorite : Icons.favorite_border),
              onPressed: product.toggleFavoriteStatus,
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cartListner.addItem(product.id, product.price, product.title);
                // this reaches out to the nearest scaffold in widget tree
                // open drawer only works if nearest scafoold has an drawer
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Added Item to cart",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartListner.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
            ),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

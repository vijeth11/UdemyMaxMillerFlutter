import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' as cartData;
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartListener = Provider.of<cartData.Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text('\$${cartListener.totalAmount}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium
                                    ?.color)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(onPressed: () {}, child: Text("ORDER NOW"))
                    ],
                  ),
                )),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, index) {
                cartData.CartItem element =
                    cartListener.items.values.toList()[index];
                return CartItem(
                  cartId: element.id,
                  title: element.title,
                  quantity: element.quantity,
                  price: element.price,
                  productId: cartListener.items.keys.toList()[index],
                );
              },
              itemCount: cartListener.items.length,
            ))
          ],
        ));
  }
}

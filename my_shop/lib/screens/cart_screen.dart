import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' as cartData;
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartListener = Provider.of<cartData.Cart>(context);
    final orderListner = Provider.of<Orders>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(
                            '\$${cartListener.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium
                                    ?.color)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                          onPressed: () {
                            orderListner.addOrder(
                                cartListener.items.values.toList(),
                                cartListener.totalAmount);
                            cartListener.clear();
                          },
                          child: const Text("ORDER NOW"))
                    ],
                  ),
                )),
            const SizedBox(height: 10),
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

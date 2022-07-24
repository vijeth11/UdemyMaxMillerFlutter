import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/widgets/display_error.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' as cartData;
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
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
                      _isLoading
                          ? Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : TextButton(
                              onPressed: cartListener.totalAmount <= 0
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      orderListner
                                          .addOrder(
                                              cartListener.items.values
                                                  .toList(),
                                              cartListener.totalAmount)
                                          .then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Order Added Successfully. Go to Order Page')));
                                        cartListener.clear();
                                        Navigator.of(context).pop();
                                      }).catchError((error) {
                                        displayError(error, context, () {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        });
                                      });
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

import 'package:flutter/material.dart';
import 'package:my_shop/widgets/display_error.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' as Order;
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<Order.Orders>(context, listen: false)
        .fetchAllOrders()
        .then((_) => setState(() {
              _isLoading = false;
            }))
        .catchError((error) {
      displayError(
          error,
          context,
          () => setState(() {
                _isLoading = false;
              }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderListner = Provider.of<Order.Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        body: RefreshIndicator(
            onRefresh: () => Provider.of<Order.Orders>(context, listen: false)
                .fetchAllOrders(),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return OrderItem(order: orderListner.orders[index]);
                    },
                    itemCount: orderListner.orders.length,
                  )));
  }
}

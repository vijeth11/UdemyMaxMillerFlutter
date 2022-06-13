import 'package:flutter/material.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' as Order;
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
   static const String routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderListner = Provider.of<Order.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body:ListView.builder(itemBuilder: (ctx,index){
        return OrderItem(order: orderListner.orders[index]);
      }, itemCount: orderListner.orders.length,));
  }
}

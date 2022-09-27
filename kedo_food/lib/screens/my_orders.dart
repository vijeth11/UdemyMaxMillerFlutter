import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:kedo_food/providers/order_items_provider.dart';
import 'package:kedo_food/screens/order_detail_screen.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  static const String routeName = 'MyOrders';
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...getPageHeader("My Orders", context, titlePladding: 50),
          Expanded(
            child: FutureBuilder(
                future: Provider.of<OrderItemProvider>(context, listen: false)
                    .fetchOrderDetails(),
                builder: (context, snapShot) {
                  return snapShot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RefreshIndicator(
                          onRefresh: () => Provider.of<OrderItemProvider>(
                                  context,
                                  listen: false)
                              .fetchOrderDetails(),
                          child: SingleChildScrollView(
                            child: Consumer<OrderItemProvider>(
                                builder: (context, orderItem, _) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ...orderItem.items.map((e) => getOrderCard(e))
                                ],
                              );
                            }),
                          ));
                }),
          )
        ],
      ),
    );
  }

  Widget getOrderCard(OrderDetail detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(OrderDetailScreen.routeName, arguments: detail),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: detail.orderStatus == Status.Delivered
                            ? Colors.green
                            : detail.orderStatus == Status.InProgress
                                ? Colors.yellow.shade600
                                : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      detail.orderId,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  detail.deliveryUserName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Cost",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    Text("\$${detail.totalCost}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("${detail.orderItemsCount} items",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          DateFormat("dd MMM yyyy hh:mm:ss")
                              .format(detail.deliveryDate),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )
                      ],
                    ),
                    Text(
                      detail.orderStatus.name,
                      style: TextStyle(
                          color: detail.orderStatus == Status.Delivered
                              ? Colors.green
                              : detail.orderStatus == Status.InProgress
                                  ? Colors.yellow.shade800
                                  : Colors.red,
                          fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

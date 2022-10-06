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
                          child: Consumer<OrderItemProvider>(
                              builder: (context, orderItem, _) {
                            if (orderItem.items.length == 0) {
                              return Center(child: getNoOrdersAvailableCard());
                            }
                            return SingleChildScrollView(
                                child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ...orderItem.items.map((e) => getOrderCard(e))
                              ],
                            ));
                          }),
                        );
                }),
          )
        ],
      ),
    );
  }

  Widget getNoOrdersAvailableCard() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset('assets/images/ordersEmpty.png'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "No Orders Yet",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Looks like you, haven't",
          style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
        ),
        Text("made your menu yet.",
            style: TextStyle(fontSize: 20, color: Colors.grey.shade600)),
        const SizedBox(
          height: 40,
        ),
        OutlinedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.green, width: 2))),
            onPressed: () {
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            },
            child: const Text(
              "Shop Now",
              style: TextStyle(color: Colors.green, fontSize: 18),
            ))
      ],
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

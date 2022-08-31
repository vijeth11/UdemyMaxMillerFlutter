import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/model/cart_item.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:kedo_food/screens/order_detail_screen.dart';
import 'package:kedo_food/widgets/page_header.dart';

class MyOrders extends StatefulWidget {
  static const String routeName = 'MyOrders';

  List<OrderDetail> orders = [
    OrderDetail(
        orderId: getRandomString(10),
        orderDate: DateTime.now(),
        orderPayement: Payment.Card,
        orderStatus: Status.Delivered,
        orderItems: [
          CartItem(
              categoryName: 'Fruit',
              itemName: 'Grapes',
              quantity: 5,
              itemCost: 5.7,
              itemImage: 'item-brocoli.png'),
          CartItem(
              categoryName: 'Mushroom',
              itemName: 'Oyster Mushroom',
              quantity: 4,
              itemCost: 2.7,
              itemImage: 'item-brocoli.png')
        ],
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        deliveryAddress:
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu",
        deliveryUserName: "RichBrown",
        deliveryUserPhone: "(+91) 123 456 7890"),
    OrderDetail(
        orderId: getRandomString(10),
        orderDate: DateTime.now(),
        orderPayement: Payment.Card,
        orderStatus: Status.Delivered,
        orderItems: [
          CartItem(
              categoryName: 'Vegetable',
              itemName: 'Broccoli',
              quantity: 3,
              itemCost: 6.3,
              itemImage: 'item-brocoli.png'),
          CartItem(
              categoryName: 'Fruit',
              itemName: 'Grapes',
              quantity: 5,
              itemCost: 5.7,
              itemImage: 'item-brocoli.png'),
          CartItem(
              categoryName: 'Mushroom',
              itemName: 'Oyster Mushroom',
              quantity: 4,
              itemCost: 2.7,
              itemImage: 'item-brocoli.png')
        ],
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        deliveryAddress:
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu",
        deliveryUserName: "RichBrown",
        deliveryUserPhone: "(+91) 123 456 7890"),
    OrderDetail(
        orderId: getRandomString(10),
        orderDate: DateTime.now(),
        orderPayement: Payment.Card,
        orderStatus: Status.Canceled,
        orderItems: [
          CartItem(
              categoryName: 'Fruit',
              itemName: 'Banana',
              quantity: 4,
              itemCost: 7.2,
              itemImage: 'item-brocoli.png'),
          CartItem(
              categoryName: 'Vegetable',
              itemName: 'Broccoli',
              quantity: 3,
              itemCost: 6.3,
              itemImage: 'item-brocoli.png'),
          CartItem(
              categoryName: 'Fruit',
              itemName: 'Grapes',
              quantity: 5,
              itemCost: 5.7,
              itemImage: 'item-brocoli.png'),
        ],
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        deliveryAddress:
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu",
        deliveryUserName: "RichBrown",
        deliveryUserPhone: "(+91) 123 456 7890")
  ];

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ...widget.orders.map((e) => getOrderCard(e))
                ],
              ),
            ),
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
                    Text("Total Cost",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    Text("\$${detail.totalCost}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
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

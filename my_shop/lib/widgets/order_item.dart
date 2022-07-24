import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as OrderDetails;

class OrderItem extends StatefulWidget {
  final OrderDetails.OrderItem order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isTileExpanded
          ? min(widget.order.products.length * 20 + 110, 200)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                  icon: Icon(
                      isTileExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isTileExpanded = !isTileExpanded;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isTileExpanded
                  ? min(widget.order.products.length * 20 + 10, 100)
                  : 0,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: [
                  ...widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ))
                      .toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/screen/order_screen.dart';
import 'package:grocia/widgets/order_card.dart';
import 'package:routemaster/routemaster.dart';

class OrderList extends StatelessWidget {
  final List<OrderDetailModel> orders;
  const OrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: kGreyLightColor),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Routemaster.of(context)
                  .push("${OrderScreen.routeName}/${orders[index].orderId}")
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: OrderCard(order: orders[index]),
            ),
          );
        },
      ),
    );
  }
}

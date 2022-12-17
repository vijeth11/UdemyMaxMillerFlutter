import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/constants/order-detail-constants.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/provider/order_detail_provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class OrderDetailScreen extends StatelessWidget {
  final String OrderId;
  static const int iconIndex = 2;

  const OrderDetailScreen({super.key, required this.OrderId});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailProvider>(context, listen: false);
    OrderDetailModel model = provider.items.firstWhere(
      (element) => element.orderId == OrderId,
    );
    return Scaffold(
      appBar: BackActionAppBar(context, "ID #${model.orderId}"),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        getOrderDeliveryAndReviewSection(model),
        getOrderStatusSection(model),
        getOrderDeliveryAddressSection(model),
        getOrderItemsSection(model, context),
        getOrderTotalSection(model)
      ]),
      bottomNavigationBar: const BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }

  Widget getOrderDeliveryAndReviewSection(OrderDetailModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(
                width: 5,
              ),
              Text(
                DateFormat("dd MMMM yyyy, hh:mm a").format(model.deliveryDate),
                style: const TextStyle(fontSize: 17),
              )
            ],
          ),
          //TODO: Creart a user review page
          TextButton(
              onPressed: () {},
              child: const Text(
                "Review",
                style: TextStyle(color: kGreenColor, fontSize: 17),
              ))
        ],
      ),
    );
  }

  Widget getOrderStatusSection(OrderDetailModel model) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        color: kGreyLightColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Order Status",
            style: orderDetailScreenHeaderStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          ...getOrderStatusList(model.orderStatus)
        ]));
  }

  List<Widget> getOrderStatusList(Status orderStatus) {
    List<Widget> statusList = [];
    switch (orderStatus) {
      case Status.Delivered:
        for (var message in orderDetailOrderStatusList) {
          statusList.addAll(orderStatusDisplay(message));
        }
        break;
      case Status.InProgress:
        statusList.addAll(orderStatusDisplay(orderDetailPreparingOrder));
        for (var message in orderDetailOrderStatusList.skip(1)) {
          statusList.addAll(orderStatusDisplay(message, iconCheck: false));
        }
        break;
      case Status.Canceled:
        statusList.addAll(orderStatusDisplay(orderDetailOrdered));
        statusList
            .addAll(orderStatusDisplay(orderDetailCanceled, iconCheck: false));
        break;
      case Status.PaymentFailed:
        statusList.addAll(orderStatusDisplay(orderDetailOrdered));
        statusList.addAll(
            orderStatusDisplay(orderDetailPaymentFailed, iconCheck: false));
        break;
    }
    return statusList;
  }

  List<Widget> orderStatusDisplay(String message, {bool iconCheck = true}) {
    return [
      Row(
        children: [
          Icon(
            iconCheck ? Icons.check : Icons.close,
            color: iconCheck ? kGreenColor : kRedColor,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
      const SizedBox(
        height: 7.0,
      )
    ];
  }

  Widget getOrderDeliveryAddressSection(OrderDetailModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          const Text(
            "Destination",
            style: orderDetailScreenHeaderStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(model.deliveryAddress.toString())
        ],
      ),
    );
  }

  Widget getOrderItemsSection(OrderDetailModel model, BuildContext context) {
    return Container(
      color: kGreyLightColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.26,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Items",
              style: orderDetailScreenHeaderStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            ...model.items
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage("assets/images/${e.itemImage}"),
                            width: 40,
                            height: 40,
                          ),
                          Text(
                            e.itemName,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${e.quantity} X ${e.itemCost}",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }

  Widget getOrderTotalSection(OrderDetailModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total Cost",
            style: orderDetailScreenHeaderStyle,
          ),
          Text(
            "Rs ${model.totalCost}",
            style: orderDetailScreenHeaderStyle,
          )
        ],
      ),
    );
  }
}

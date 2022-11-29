import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderDetailModel order;

  const OrderCard({super.key, required this.order});

  List<Color> getStatusColor(Status orderStatus) {
    switch (orderStatus) {
      case Status.Delivered:
        return [kGreenColor, kGreenColor.withOpacity(0.7)];
      case Status.InProgress:
        return [kOrangeColor, kOrangeColor.withOpacity(0.7)];
      case Status.Canceled:
        return [kRedColor, kRedColor.withOpacity(0.7)];
      case Status.PaymentFailed:
        return [kRedColor, kRedColor.withOpacity(0.7)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: getStatusColor(order.orderStatus))),
                      child: Text(
                        order.orderStatus.name,
                        style: const TextStyle(
                            color: kWhiteColor, fontSize: appFontSize),
                      )),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    Text(
                      DateFormat("dd/mm/yyyy").format(order.deliveryDate),
                      style: const TextStyle(fontSize: appFontSize),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Transaction. ID",
                        style: TextStyle(color: kGreyColor)),
                    Text(
                      order.invoiceNo,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: appFontSize),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Delivered to",
                        style: TextStyle(color: kGreyColor)),
                    Text(order.deliveryAddress.Address,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: appFontSize))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Payment",
                        style: TextStyle(color: kGreyColor)),
                    Text('\$${order.totalCost}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: appFontSize))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

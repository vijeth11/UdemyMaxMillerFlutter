import 'package:flutter/material.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:kedo_food/widgets/page_header.dart';

class OrderDetailScreen extends StatelessWidget {
  static const String routeName = "OrderDetail";
  late OrderDetail order;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    order = ModalRoute.of(context)!.settings.arguments as OrderDetail;
    return Scaffold(
      body: Column(
        children: [
          ...getPageHeader("Order Detail", context, titlePladding: 55),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                getTheSectionName("Invoice"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 5.0),
                  child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        getInvoiceDetailSection("Invoice No", order.invoiceNo),
                        getInvoiceDetailSection("Order No", order.orderId),
                        getInvoiceDetailSection(
                            "User Name", order.deliveryUserName),
                        getInvoiceDetailSection(
                            "Payment By", order.orderPayement.name),
                        getInvoiceDetailSection(
                            "Order Items", "${order.orderItemsCount} Items"),
                        getInvoiceDetailSection("Total", "\$${order.totalCost}")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                getTheSectionName("Address"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 5.0),
                  child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              order.deliveryUserName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              order.deliveryAddress,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.phone),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  order.deliveryUserPhone,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                getTheSectionName("Items"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 5.0),
                  child: Card(
                    elevation: 12,
                    child: SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 0),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.grey,
                          height: 5,
                        ),
                        itemCount: order.orderItems.length,
                        itemBuilder: displayItemList,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget displayItemList(BuildContext context, int index) {
    var e = order.orderItems[index];
    return ListTile(
      leading: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage("assets/images/${e.itemImage}"),
                fit: BoxFit.cover)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.categoryName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          Text(
            e.itemName,
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Text(
            "Qty ${e.quantity}",
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.grey),
          )
        ],
      ),
      trailing: Text("\$${e.itemCost * e.quantity}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          )),
    );
  }

  Widget getTheSectionName(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      child: Text(name,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 17)),
    );
  }

  Widget getInvoiceDetailSection(String sectionName, String sectionValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sectionName),
          Text(
            sectionValue,
            style: const TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

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
      body: Column(children: [
        ...getPageHeader("Order Detail", context,titlePladding: 55),
        Center(child:Text("Yet to build"))
      ],),
    );
  }
}

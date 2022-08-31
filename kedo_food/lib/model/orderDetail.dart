import 'package:kedo_food/model/cart_item.dart';

enum Status { Delivered, Canceled, PaymentFailed }

enum Payment { Card, Cash, UPI }

class OrderDetail {
  final String orderId;
  final DateTime orderDate;
  final Payment orderPayement;
  final Status orderStatus;
  final List<CartItem> orderItems;
  final DateTime deliveryDate;
  final String deliveryAddress;
  final String deliveryUserName;
  final String deliveryUserPhone;

  OrderDetail(
      {required this.orderId,
      required this.orderDate,
      required this.orderPayement,
      required this.orderStatus,
      required this.orderItems,
      required this.deliveryDate,
      required this.deliveryAddress,
      required this.deliveryUserName,
      required this.deliveryUserPhone});

  int get orderItemsCount {
    return orderItems.length;
  }

  double get totalCost {
    return orderItems
        .map((e) => e.itemCost)
        .reduce((value, element) => value + element);
  }
}

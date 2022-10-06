import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kedo_food/model/cart_item.dart';

enum Status { Delivered, Canceled, PaymentFailed, InProgress }

enum Payment { Card, Cash, UPI }

class OrderDetail {
  final String userId;
  final String orderId;
  final String invoiceNo;
  final DateTime orderDate;
  final Payment orderPayement;
  final Status orderStatus;
  final List<CartItem> orderItems;
  final DateTime deliveryDate;
  final String deliveryAddress;
  final String deliveryZipCode;
  final String deliveryCity;
  final String deliveryCountry;
  final String deliveryUserName;
  final String deliveryUserPhone;
  final String deliveryUserEmail;

  OrderDetail(
      {required this.userId,
      required this.orderId,
      required this.invoiceNo,
      required this.orderDate,
      required this.orderPayement,
      required this.orderStatus,
      required this.orderItems,
      required this.deliveryDate,
      required this.deliveryAddress,
      required this.deliveryZipCode,
      required this.deliveryCity,
      required this.deliveryCountry,
      required this.deliveryUserName,
      required this.deliveryUserPhone,
      required this.deliveryUserEmail});

  int get orderItemsCount {
    return orderItems.length;
  }

  double get totalCost {
    return orderItems
        .map((e) => e.itemCost * e.quantity)
        .reduce((value, element) => value + element);
  }

  String get Address {
    return "$deliveryAddress\n$deliveryCity $deliveryCountry\n$deliveryZipCode";
  }

  @override
  String toString() {
    // TODO: implement toString
    return toMap().toString();
  }

  OrderDetail copyWith(
          {String? userId,
          String? orderId,
          String? invoiceNo,
          DateTime? orderDate,
          Payment? orderPayement,
          Status? orderStatus,
          List<CartItem>? orderItems,
          DateTime? deliveryDate,
          String? deliveryAddress,
          String? deliveryZipCode,
          String? deliveryCity,
          String? deliveryCountry,
          String? deliveryUserName,
          String? deliveryUserPhone,
          String? deliveryUserEmail}) =>
      OrderDetail(
          userId: userId ?? this.userId,
          orderId: orderId ?? this.orderId,
          invoiceNo: invoiceNo ?? this.invoiceNo,
          orderDate: orderDate ?? this.orderDate,
          orderPayement: orderPayement ?? this.orderPayement,
          orderStatus: orderStatus ?? this.orderStatus,
          orderItems: orderItems ?? this.orderItems,
          deliveryDate: deliveryDate ?? this.deliveryDate,
          deliveryAddress: deliveryAddress ?? this.deliveryAddress,
          deliveryZipCode: deliveryZipCode ?? this.deliveryZipCode,
          deliveryCity: deliveryCity ?? this.deliveryCity,
          deliveryCountry: deliveryCountry ?? this.deliveryCountry,
          deliveryUserName: deliveryUserName ?? this.deliveryUserName,
          deliveryUserPhone: deliveryUserPhone ?? this.deliveryUserPhone,
          deliveryUserEmail: deliveryUserEmail ?? this.deliveryUserEmail);

  Map<String, Object> toMap() {
    return {
      'userId':userId,
      'orderId': orderId,
      'invoiceNo': invoiceNo,
      'orderDate': DateFormat('dd/mm/yyyy hh:mm:ss').format(orderDate),
      'orderPayement': orderPayement.toString(),
      'orderStatus': orderStatus.toString(),
      'orderItems': orderItems.map((e) => e.toMap()).toList(),
      'deliveryDate': DateFormat('dd/mm/yyyy hh:mm:ss').format(deliveryDate),
      'deliveryAddress': deliveryAddress,
      'deliveryZipCode': deliveryZipCode,
      'deliveryCity': deliveryCity,
      'deliveryCountry': deliveryCountry,
      'deliveryUserName': deliveryUserName,
      'deliveryUserPhone': deliveryUserPhone,
      'deliveryUserEmail': deliveryUserEmail
    };
  }
}

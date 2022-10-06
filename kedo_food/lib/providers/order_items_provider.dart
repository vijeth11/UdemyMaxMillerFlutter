import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kedo_food/model/cart_item.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:http/http.dart' as http;

class OrderItemProvider with ChangeNotifier {
  late String url;
  late String _userId;
  OrderItemProvider(String userId) {
    url = "https://flutter-kedo-food-default-rtdb.firebaseio.com/orders.json";
    _userId = userId;
  }

  List<OrderDetail> _items = [];

  List<OrderDetail> get items {
    return [..._items];
  }

  Future<void> addOrderDetails(OrderDetail detail) async {
    try {
      detail = detail.copyWith(userId: _userId);
      await http.post(Uri.parse(url), body: json.encode(detail.toMap()));
      _items.add(detail);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchOrderDetails() async {
    try {
      var response = await http.get(Uri.parse(url));
      _items = [];
      if (response.body != "null") {
        final orderData = json.decode(response.body) as Map<String, dynamic>;
        print(orderData);
        for (var order in orderData.values) {
          _items.add(OrderDetail(
              userId: order['userId'] as String,
              orderId: order['orderId'] as String,
              invoiceNo: order['invoiceNo'] as String,
              orderDate:
                  DateFormat('dd/mm/yyyy hh:mm:ss').parse(order['orderDate']),
              orderPayement: Payment.values
                  .firstWhere((e) => e.toString() == order['orderPayement']),
              orderStatus: Status.values
                  .firstWhere((e) => e.toString() == order['orderStatus']),
              orderItems: _getOrderItems(order['orderItems']),
              deliveryDate: DateFormat('dd/mm/yyyy hh:mm:ss')
                  .parse(order['deliveryDate']),
              deliveryAddress: order['deliveryAddress'] as String,
              deliveryZipCode: order['deliveryZipCode'] as String,
              deliveryCity: order['deliveryCity'] as String,
              deliveryCountry: order['deliveryCountry'] as String,
              deliveryUserName: order['deliveryUserName'] as String,
              deliveryUserPhone: order['deliveryUserPhone'] as String,
              deliveryUserEmail: order['deliveryUserEmail'] as String));
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  List<CartItem> _getOrderItems(dynamic data) {
    List<CartItem> orderItems = [];
    for (var item in data) {
      orderItems.add(CartItem(
          categoryName: item['categoryName'] as String,
          itemName: item['itemName'] as String,
          itemId: item['itemId'] as String,
          quantity: item['quantity'] as int,
          itemCost: item['itemCost'] as double,
          itemImage: item['itemImage'] as String));
    }
    return orderItems;
  }
}

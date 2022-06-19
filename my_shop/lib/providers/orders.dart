import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String url =
      'https://flutter-shop-c7794-default-rtdb.firebaseio.com/orders.json';
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void fetchAllOrders() async {
    try {
      var response = await http.get(Uri.parse(url));
      var orderResponse = json.decode(response.body) as Map<String, dynamic>;
      orderResponse.forEach((key, value) {});
    } catch (error) {
      throw error;
    }
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}

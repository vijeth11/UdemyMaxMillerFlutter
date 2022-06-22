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

  Future<void> fetchAllOrders() async {
    try {
      var response = await http.get(Uri.parse(url));
      List<OrderItem> loadedOrders = [];
      var orderResponse = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      orderResponse.forEach((key, value) {
        loadedOrders.add(OrderItem(
            id: key,
            amount: value['amount'],
            products: [
              ...(value['products'] as List<dynamic>)
                  .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price']))
                  .toList()
            ],
            dateTime: DateTime.parse(value['dateTime'])));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      var order = OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now());
      var response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': order.amount,
            'products': [
              ...order.products
                  .map((item) => {
                        'id': item.id,
                        'title': item.title,
                        'quantity': item.quantity,
                        'price': item.price
                      })
                  .toList()
            ],
            'dateTime': order.dateTime.toString()
          }));
      var id = json.decode(response.body)['name'];
      _orders.insert(
          0,
          OrderItem(
              id: id,
              amount: order.amount,
              products: order.products,
              dateTime: order.dateTime));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

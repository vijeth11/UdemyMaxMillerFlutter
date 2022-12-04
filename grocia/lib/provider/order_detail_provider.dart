import 'package:flutter/material.dart';
import 'package:grocia/model/order_detail_model.dart';

class OrderDetailProvider extends ChangeNotifier {
  final List<OrderDetailModel> _items;
  OrderDetailProvider(this._items);

  List<OrderDetailModel> get items {
    return [..._items];
  }

  void addOrderDetail(OrderDetailModel detail) {
    _items.add(detail);
    notifyListeners();
  }

  void fetchOrderDetails() {}
}

import 'package:flutter/material.dart';
import 'package:grocia/model/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> _items = [];
  List<CartItemModel> get items {
    return _items;
  }

  void addItemToCart(CartItemModel item) {
    if (_items.any((element) => element.itemName == item.itemName)) {
      final oldItemIndex =
          _items.indexWhere((element) => element.itemName == item.itemName);
      CartItemModel updateItem =
          item.copyTo(quantity: _items[oldItemIndex].quantity + 1);
      _items[oldItemIndex] = updateItem;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItemFromCart(CartItemModel item) {
    if (_items.any((element) => element.itemName == item.itemName)) {
      final index =
          _items.indexWhere((element) => element.itemName == item.itemName);
      if (_items[index].quantity - 1 > 0) {
        CartItemModel updateItem =
            item.copyTo(quantity: _items[index].quantity - 1);
        _items[index] = updateItem;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    } else {
      throw ErrorDescription("Item not found");
    }
  }

  void removeAll() {
    _items = [];
    notifyListeners();
  }
}

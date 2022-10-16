import 'package:flutter/cupertino.dart';
import 'package:kedo_food/helper/db_helper.dart';
import 'package:kedo_food/model/cart_item.dart';
import 'package:kedo_food/model/market_item.dart';

class CartItemProvider extends ChangeNotifier {
  late List<MarketItem> marketItems;
  late bool loadDataFromDatabase;
  CartItemProvider(this.marketItems, this._items, this.loadDataFromDatabase);

  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  Future<void> fetchDataFromDatabase() async {
    var data = await DBHelper.getData('cart_items');
    data.forEach((e) => _items.add(CartItem(
        categoryName: e['categoryName'] as String,
        itemName: e['itemName'] as String,
        itemId: e['itemId'] as String,
        quantity: e['quantity'] as int,
        itemCost: e['itemCost'] as double,
        itemImage: e['itemImage'] as String)));
    notifyListeners();
  }

  void addItemToCart(String itemId, {int quantity = 1}) async {
    if (_items.any(
      (element) => element.itemId == itemId,
    )) {
      int index = _items.indexWhere((element) => element.itemId == itemId);
      CartItem updateItem = CartItem(
          categoryName: _items[index].categoryName,
          itemCost: _items[index].itemCost,
          itemId: itemId,
          itemImage: _items[index].itemImage,
          itemName: _items[index].itemName,
          quantity: _items[index].quantity + quantity);
      _items[index] = updateItem;
      await DBHelper.update(
          'cart_items', updateItem.toMap(), 'itemId = ?', [updateItem.itemId]);
    } else {
      MarketItem product =
          marketItems.firstWhere((element) => element.id == itemId);
      CartItem newItem = CartItem(
          categoryName: product.categoryName,
          itemName: product.name,
          itemId: itemId,
          quantity: quantity,
          itemCost: product.cost,
          itemImage: product.image);
      _items.add(newItem);
      await DBHelper.insert('cart_items', newItem.toMap());
    }
    notifyListeners();
  }

  void removeItemFromCart(String itemId) async {
    if (_items.any((element) => element.itemId == itemId)) {
      int index = _items.indexWhere((element) => element.itemId == itemId);
      if (_items[index].quantity - 1 > 0) {
        CartItem updateItem = CartItem(
            categoryName: _items[index].categoryName,
            itemCost: _items[index].itemCost,
            itemId: itemId,
            itemImage: _items[index].itemImage,
            itemName: _items[index].itemName,
            quantity: _items[index].quantity - 1);
        _items[index] = updateItem;
        await DBHelper.update('cart_items', updateItem.toMap(), 'itemId = ?',
            [updateItem.itemId]);
      } else {
        _items.removeAt(index);
        await DBHelper.remove('cart_items', 'itemId = ?', [itemId]);
      }
      notifyListeners();
    } else {
      throw ErrorDescription("Item not found");
    }
  }

  Future<void> removeAll() async {
    _items = [];
    await DBHelper.RemoveAll('cart_items');
    notifyListeners();
  }
}

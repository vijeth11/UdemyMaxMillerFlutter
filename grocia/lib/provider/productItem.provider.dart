import 'package:flutter/cupertino.dart';
import 'package:grocia/model/item_model.dart';

class ProductItemProvider extends ChangeNotifier {
  final List<ItemModel> _items;

  ProductItemProvider(this._items);

  List<ItemModel> get items {
    return _items;
  }

  ItemModel getItemById(int id) {
    return items.firstWhere((item) => item.id == id);
  }
}

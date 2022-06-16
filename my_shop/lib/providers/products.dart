import 'dart:ffi';

import 'package:flutter/material.dart';
import 'product.dart';

// this is a state management in flutter using this we can create listners
// and only re-render those part of application on data change.
// this is like Subject and Observables in Angular4+
// this class to be recognised as Notifier State class it needs mixin ChangeNotifier
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.favourite).toList();
  }

  void addProduct(Product value) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: value.title,
        description: value.description,
        price: value.price,
        imageUrl: value.imageUrl);
    _items.add(newProduct);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }

  void updateProduct(String id, Product value) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = value;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

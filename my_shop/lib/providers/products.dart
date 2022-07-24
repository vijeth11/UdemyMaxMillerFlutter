import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_shop/models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

// this is a state management in flutter using this we can create listners
// and only re-render those part of application on data change.
// this is like Subject and Observables in Angular4+
// this class to be recognised as Notifier State class it needs mixin ChangeNotifier
class Products with ChangeNotifier {
  late String url;
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items) {
    url =
        "https://flutter-shop-c7794-default-rtdb.firebaseio.com/products.json?auth=$authToken";
  }

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.favourite).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    try {
      var response = await http.get(Uri.parse(
          "https://flutter-shop-c7794-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken"));
      final favourites = json.decode(response.body);
      response = await http.get(Uri.parse(url +
          (filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '')));
      print(response.body);
      final List<Product> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        loadedData.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          imageUrl: value['imageUrl'],
          price: value['price'],
          favourite: favourites == null || favourites[key] == null
              ? false
              : favourites[key]['favourite'] ?? false,
        ));
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product value) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': value.title,
            'description': value.description,
            'price': value.price,
            'imageUrl': value.imageUrl,
            'creatorId': userId
          }));
      print(response.body);
      var id = json.decode(response.body)['name'];
      final newProduct = Product(
          id: id,
          title: value.title,
          description: value.description,
          price: value.price,
          imageUrl: value.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<void> updateProduct(String id, Product value) async {
    final updateUrl =
        "https://flutter-shop-c7794-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";

    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      try {
        await http.patch(Uri.parse(updateUrl),
            body: json.encode({
              'title': value.title,
              'price': value.price,
              'description': value.description,
              'imageUrl': value.imageUrl,
              'creatorId': userId
            }));
        _items[prodIndex] = value;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteProduct(String id) {
    final deleteUrl =
        "https://flutter-shop-c7794-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    return http.delete(Uri.parse(deleteUrl)).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product.');
      }
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }
}

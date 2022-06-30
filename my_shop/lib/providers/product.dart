import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool favourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.favourite = false});

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    try {
      var response = await http.put(
          Uri.parse(
              "https://flutter-shop-c7794-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token"),
          body: json.encode({
            'favourite': !favourite,
          }));
      if (response.statusCode >= 400) {
        throw HttpException('Something failed in network');
      }
      favourite = !favourite;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

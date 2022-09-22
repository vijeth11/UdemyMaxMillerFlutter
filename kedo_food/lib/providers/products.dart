import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kedo_food/model/category_tile_detail.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Products with ChangeNotifier {
  late String url;

  Products() {
    url = "https://flutter-kedo-food-default-rtdb.firebaseio.com/products.json";
  }

  int _currentPageNumber = 1;

  int get pageNumber {
    return _currentPageNumber;
  }

  updatePageNumber() {
    if (_currentPageNumber < 4) {
      _currentPageNumber += 1;
    } else {
      _currentPageNumber = 1;
    }
    notifyListeners();
  }

  List<MarketItem> _items = [];

  List<MarketItem> get items {
    return [..._items];
  }

  List<MarketItem> trendingItems() {
    List<MarketItem> trends = [];
    if (_currentPageNumber < 4) {
      for (int i = 0; i < _currentPageNumber; i++) {
        for (String category in categoryTiles.map((e) => e.title)) {
          trends.add((items
              .where((element) => element.categoryName == category)
              .toList())[i]);
        }
      }
    }
    return trends;
  }

  Future<void> fetchProducts() async {
    try {
      var response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData.values);
      for (var product in extractedData.values) {
        var reviews = [];
        for (var review in product['reviews']) {
          reviews.add(Review(
              name: review['name'],
              review: review['review'],
              rating: (review['rating'] as int).toDouble(),
              date: DateFormat('dd/mm/yyyy').parse(review['date']),
              image: review['image']));
        }
        _items.add(MarketItem(
            id: extractedData.entries
                .where((element) => element.value == product)
                .first
                .key,
            name: product['name'],
            cost: product['cost'],
            categoryName: product['categoryName'],
            isFavourite: product['isFavourite'],
            image: product['image'],
            rating: product['rating'] as double,
            reviews: [...reviews],
            description: product['description'],
            discussion: product['discussion']));
      }
      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }

  void addProductItem(MarketItem item) {
    _items.add(item);
    notifyListeners();
  }
}

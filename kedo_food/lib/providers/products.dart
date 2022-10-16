import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:kedo_food/model/category_tile_detail.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Products with ChangeNotifier {
  late String url;
  late String authToken;
  late String userId;

  Products(this.authToken, this.userId, this._items) {
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
  List<Map<String, String>> _favouriteMarketItems = [];

  List<MarketItem> get items {
    return [..._items];
  }

  List<MarketItem> favouriteItems() {
    return items.where((element) => element.isFavourite).toList();
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
      await fetchFavourite();
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData.values);
      for (var product in extractedData.values) {
        String productId = extractedData.entries
            .where((element) => element.value == product)
            .first
            .key;
        var reviews = await fetchProductReviews(productId);
        _items.add(MarketItem(
            id: productId,
            name: product['name'],
            cost: product['cost'],
            categoryName: product['categoryName'],
            isFavourite: _favouriteMarketItems
                .any((element) => element["itemId"] == productId),
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

  Future<void> addFavourite(String itemId) async {
    try {
      String url =
          'https://flutter-kedo-food-default-rtdb.firebaseio.com/userfavourite.json?auth=$authToken';
      var response = await http.post(Uri.parse(url),
          body: json.encode({'marketItemId': itemId, 'userId': userId}));
      var responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      _favouriteMarketItems.add({"id": responseBody["name"], "itemId": itemId});
      MarketItem item = _items.firstWhere((element) => element.id == itemId);
      int index = _items.indexOf(item);
      item = item.copyTo(isFavourite: true);
      _items[index] = item;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeFavourite(String itemId) async {
    try {
      var favObj = _favouriteMarketItems
          .where((element) => element['itemId'] == itemId)
          .first;
      String keyId = favObj["id"] ?? "";
      String url =
          'https://flutter-kedo-food-default-rtdb.firebaseio.com/userfavourite/$keyId.json?auth=$authToken';
      print(url);
      await http.delete(Uri.parse(url));
      _favouriteMarketItems.remove(favObj);
      MarketItem item = _items.firstWhere((element) => element.id == itemId);
      int index = _items.indexOf(item);
      item = item.copyTo(isFavourite: false);
      _items[index] = item;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<void> fetchFavourite() async {
    try {
      String url =
          'https://flutter-kedo-food-default-rtdb.firebaseio.com/userfavourite.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
      _favouriteMarketItems = [];
      var response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else if (response.body != "null") {
        for (var itemIds in responseData.values) {
          _favouriteMarketItems.add({
            "id": responseData.entries
                .where((element) => element.value == itemIds)
                .first
                .key,
            "itemId": itemIds['marketItemId'] as String
          });
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Review>> fetchProductReviews(String productId) async {
    try {
      String url =
          'https://flutter-kedo-food-default-rtdb.firebaseio.com/productreview.json?auth=$authToken&orderBy="productId"&equalTo="$productId"';
      List<Review> reviews = [];
      var response = await http.get(Uri.parse(url));
      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else if (response.body != "null") {
        for (var review in responseData.values) {
          reviews.add(Review(
              userName: review['userName'],
              review: review['review'],
              rating: review['rating'] as double,
              date: DateFormat('dd/mm/yyyy').parse(review['date']),
              userImage: review['userImage'],
              productId: productId));
        }
      }
      return reviews;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addProductReview(Review review) async {
    String url =
        'https://flutter-kedo-food-default-rtdb.firebaseio.com/productreview.json?auth=$authToken';
    await http.post(Uri.parse(url), body: json.encode(review.toMap()));
    MarketItem item =
        _items.where((element) => element.id == review.productId).first;
    int index = _items.indexOf(item);
    item.reviews.add(review);
    _items[index] = item;
    notifyListeners();
  }
}

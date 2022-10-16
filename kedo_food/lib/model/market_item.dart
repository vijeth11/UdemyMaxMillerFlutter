import 'package:intl/intl.dart';
import 'package:kedo_food/helper/utils.dart';

class MarketItem {
  final String id;
  final String name;
  final double cost;
  final String categoryName;
  final bool isFavourite;
  final String image;
  final double rating;
  final String description;
  final String discussion;
  final List<Review> reviews;

  MarketItem(
      {required this.id,
      required this.name,
      required this.cost,
      required this.categoryName,
      required this.isFavourite,
      required this.image,
      required this.rating,
      required this.reviews,
      required this.description,
      required this.discussion});

  MarketItem copyTo({
    String? id,
    String? name,
    double? cost,
    String? categoryName,
    bool? isFavourite,
    String? image,
    double? rating,
    String? description,
    String? discussion,
    List<Review>? reviews,
  }) =>
      MarketItem(
          id: id ?? this.id,
          name: name ?? this.name,
          cost: cost ?? this.cost,
          categoryName: categoryName ?? this.categoryName,
          isFavourite: isFavourite ?? this.isFavourite,
          image: image ?? this.image,
          rating: rating ?? this.rating,
          reviews: reviews ?? this.reviews,
          description: description ?? this.description,
          discussion: discussion ?? this.discussion);
}

class Review {
  final String userName;
  final String review;
  final double rating;
  final DateTime date;
  final String userImage;
  final String productId;
  Review(
      {required this.userName,
      required this.review,
      required this.rating,
      required this.date,
      required this.userImage,
      required this.productId});

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "review": review,
      "rating": rating,
      "date": DateFormat('dd/mm/yyyy hh:mm:ss').format(date),
      "userImage": userImage,
      "productId": productId
    };
  }

  Review copyTo(
      {String? userName,
      String? review,
      double? rating,
      DateTime? date,
      String? userImage,
      String? productId}) {
    return Review(
        userName: userName ?? this.userName,
        review: review ?? this.review,
        rating: rating ?? this.rating,
        date: date ?? this.date,
        userImage: userImage ?? this.userImage,
        productId: productId ?? this.productId);
  }
}

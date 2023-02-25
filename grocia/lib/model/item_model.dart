import 'package:grocia/constants/constants.dart';

class ItemModel {
  final String itemName;
  final double itemCost;
  final String itemImage;
  final String itemCategory;
  final double offer;
  final String description;
  final List<String> slidingImages;
  final double rating;
  final double deliveryCharges;
  final List<ReviewModel> reviews;

  ItemModel(
      this.itemName,
      this.itemCategory,
      this.itemCost,
      this.itemImage,
      this.offer,
      this.description,
      this.slidingImages,
      this.rating,
      this.deliveryCharges,
      this.reviews);

  ItemModel copyTo({
    String? itemName,
    String? itemCategory,
    double? itemCost,
    String? itemImage,
    double? offer,
    String? description,
    List<String>? slidingImages,
    double? rating,
    double? deliveryCharges,
    List<ReviewModel>? reviews,
  }) {
    return ItemModel(
        itemName ?? this.itemName,
        itemCategory ?? this.itemCategory,
        itemCost ?? this.itemCost,
        itemImage ?? this.itemImage,
        offer ?? this.offer,
        description ?? this.description,
        slidingImages ?? this.slidingImages,
        rating ?? this.rating,
        deliveryCharges ?? this.deliveryCharges,
        reviews ?? this.reviews);
  }
}

class ReviewModel {
  final String username;
  final ReviewType reviewType;
  final String review;

  ReviewModel(this.username, this.reviewType, this.review);
}

final dummyItemModels = [
  ItemModel("Chilli", categoryImages.keys.toList()[1], 80,
      "assets/images/items/Chilli.jpg", 5, "not yet", [], 3.5, 0, []),
  ItemModel("Carrot", categoryImages.keys.toList()[1], 40,
      "assets/images/items/Carrot.jpg", 10, "not yet", [], 3.5, 0, []),
  ItemModel("Cauliflower", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Cauliflower.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Cabbage", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Cabbage.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Onion", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Onion.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Tomato", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Tomato.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Star Anise", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Staranise.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Brinjal", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Brinjal.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Capsicum", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Capsicum.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Lady Finger", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Ladyfinger.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Garlic", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Garlic.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Ginger", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Ginger.jpg", 0, "not yet", [], 3.5, 0, []),
  ItemModel("Orange", categoryImages.keys.toList()[1], 120,
      "assets/images/items/orange.jpg", 0, "not yet", [
        "assets/images/items/orange1.jpg",
        "assets/images/items/orange2.jpg",
        "assets/images/items/orange3.jpg"
      ], 3.5, 0, []),
  ItemModel("Green Apple", categoryImages.keys.toList()[1], 120,
      "assets/images/items/GreenApple.jpg", 0, "not yet", [
        "assets/images/items/GreenApple1.jpg",
        "assets/images/items/GreenApple2.jpg",
        "assets/images/items/GreenApple3.jpg"
      ], 3.5, 0, []),
  ItemModel("apple", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Ginger.jpg", 0, "not yet", [
        "assets/images/items/apple1.jpg",
        "assets/images/items/apple2.jpg",
        "assets/images/items/apple3.jpg"
      ], 3.5, 0, []),
];

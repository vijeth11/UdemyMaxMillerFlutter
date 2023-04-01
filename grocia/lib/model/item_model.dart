import 'package:grocia/constants/constants.dart';

class ItemModel {
  final int id;
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
  final List<Map<String, int>> availableTypes;

  ItemModel(
      this.id,
      this.itemName,
      this.itemCategory,
      this.itemCost,
      this.itemImage,
      this.offer,
      this.description,
      this.slidingImages,
      this.rating,
      this.deliveryCharges,
      this.reviews,
      this.availableTypes);

  ItemModel copyTo({
    int? itemid,
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
    List<Map<String, int>>? availableTypes,
  }) {
    return ItemModel(
        itemid ?? id,
        itemName ?? this.itemName,
        itemCategory ?? this.itemCategory,
        itemCost ?? this.itemCost,
        itemImage ?? this.itemImage,
        offer ?? this.offer,
        description ?? this.description,
        slidingImages ?? this.slidingImages,
        rating ?? this.rating,
        deliveryCharges ?? this.deliveryCharges,
        reviews ?? this.reviews,
        availableTypes ?? this.availableTypes);
  }
}

class ReviewModel {
  final String username;
  final ReviewType reviewType;
  final String review;

  ReviewModel(this.username, this.reviewType, this.review);
}

final dummyItemModels = [
  ItemModel(1, "Chilli", categoryImages.keys.toList()[1], 80,
      "assets/images/items/Chilli.jpg", 5, "not yet", [], 3.5, 0, [], []),
  ItemModel(
      2,
      "Carrot",
      categoryImages.keys.toList()[1],
      40,
      "assets/images/items/Carrot.jpg",
      10,
      "not yet",
      [],
      3.5,
      0,
      [],
      [
        {"2 kg": 70}
      ]),
  ItemModel(3, "Cauliflower", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Cauliflower.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(4, "Cabbage", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Cabbage.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(5, "Onion", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Onion.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(6, "Tomato", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Tomato.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(7, "Star Anise", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Staranise.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(8, "Brinjal", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Brinjal.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(9, "Capsicum", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Capsicum.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(10, "Lady Finger", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Ladyfinger.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(11, "Garlic", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Garlic.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(12, "Ginger", categoryImages.keys.toList()[1], 120,
      "assets/images/items/Ginger.jpg", 0, "not yet", [], 3.5, 0, [], []),
  ItemModel(
      13,
      "Orange",
      categoryImages.keys.toList()[1],
      120,
      "assets/images/items/orange.jpg",
      0,
      "High quality Fresh Orange fruit exporters from South Korea for sale. All citrus trees belong to the single genus Citrus and remain almost entirely interfertile. This includes grapefruits, lemons, limes, oranges, and various other types and hybrids. The fruit of any citrus tree is considered a hesperidium, a kind of modified berry; it is covered by a rind originated by a rugged thickening of the ovary wall.",
      [
        "assets/images/items/orange1.jpg",
        "assets/images/items/orange2.jpg",
        "assets/images/items/orange3.jpg"
      ],
      3.5,
      0,
      [],
      [
        {"1/2 Kg": 60},
        {"2 Kg": 200},
        {"4 Kg": 430}
      ]),
  ItemModel(
      14,
      "Green Apple",
      categoryImages.keys.toList()[1],
      120,
      "assets/images/items/GreenApple.jpg",
      0,
      "High quality Fresh Orange fruit exporters from South Korea for sale. All citrus trees belong to the single genus Citrus and remain almost entirely interfertile. This includes grapefruits, lemons, limes, oranges, and various other types and hybrids. The fruit of any citrus tree is considered a hesperidium, a kind of modified berry; it is covered by a rind originated by a rugged thickening of the ovary wall.",
      [
        "assets/images/items/GreenApple1.jpg",
        "assets/images/items/GreenApple2.jpg",
        "assets/images/items/GreenApple3.jpg"
      ],
      3.5,
      0,
      [],
      [
        {"1/2 Kg": 60},
        {"2 Kg": 200},
        {"4 Kg": 430}
      ]),
  ItemModel(
      15,
      "apple",
      categoryImages.keys.toList()[1],
      120,
      "assets/images/items/Ginger.jpg",
      0,
      "High quality Fresh Orange fruit exporters from South Korea for sale. All citrus trees belong to the single genus Citrus and remain almost entirely interfertile. This includes grapefruits, lemons, limes, oranges, and various other types and hybrids. The fruit of any citrus tree is considered a hesperidium, a kind of modified berry; it is covered by a rind originated by a rugged thickening of the ovary wall.",
      [
        "assets/images/items/apple1.jpg",
        "assets/images/items/apple2.jpg",
        "assets/images/items/apple3.jpg"
      ],
      3.5,
      0,
      [],
      [
        {"1/2 Kg": 60},
        {"2 Kg": 200},
        {"4 Kg": 430}
      ]),
];

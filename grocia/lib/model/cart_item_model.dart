class CartItemModel {
  final String itemName;
  final double itemCost;
  final int quantity;
  final String itemImage;
  final double offer;

  CartItemModel(
      {required this.itemName,
      required this.itemCost,
      required this.quantity,
      required this.itemImage,
      required this.offer});

  CartItemModel copyTo(
          {String? itemName,
          double? itemCost,
          int? quantity,
          String? itemImage,
          double? offer}) =>
      CartItemModel(
          itemName: itemName ?? this.itemName,
          itemCost: itemCost ?? this.itemCost,
          quantity: quantity ?? this.quantity,
          itemImage: itemImage ?? this.itemImage,
          offer: offer ?? this.offer);
}

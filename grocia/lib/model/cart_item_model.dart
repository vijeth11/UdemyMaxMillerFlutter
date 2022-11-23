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
}

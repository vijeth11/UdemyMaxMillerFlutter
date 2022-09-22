class CartItem {
  final String categoryName;
  final String itemName;
  final String itemId;
  final int quantity;
  final double itemCost;
  final String itemImage;

  CartItem({
    required this.categoryName,
    required this.itemName,
    required this.itemId,
    required this.quantity,
    required this.itemCost,
    required this.itemImage,
  });

  Map<String, Object> toMap() {
    return {
      'itemId':itemId,
      'itemName':itemName,
      'categoryName':categoryName,
      'quantity':quantity,
      'itemCost':itemCost,
      'itemImage':itemImage
    };
  }
}

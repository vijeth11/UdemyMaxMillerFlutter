class MarketItem {
  final String name;
  final double cost;
  final bool isFavourite;
  final String image;
  final double rating;
  final List<Review> reviews;

  MarketItem(
      {required this.name,
      required this.cost,
      required this.isFavourite,
      required this.image,
      required this.rating,
      required this.reviews
      });
}

class Review {
  final String name;
  final String review;
  final double rating;
  Review({required this.name, required this.review, required this.rating});
}

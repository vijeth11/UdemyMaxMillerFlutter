class MarketItem {
  final String name;
  final double cost;
  final bool isFavourite;
  final String image;
  final double rating;
  final String description;
  final String discussion;
  final List<Review> reviews;

  MarketItem(
      {required this.name,
      required this.cost,
      required this.isFavourite,
      required this.image,
      required this.rating,
      required this.reviews,
      required this.description,
      required this.discussion});
}

class Review {
  final String name;
  final String review;
  final double rating;
  final DateTime date;
  final String image;
  Review(
      {required this.name,
      required this.review,
      required this.rating,
      required this.date,
      required this.image});
}

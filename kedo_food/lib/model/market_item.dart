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
      {
      required this.id,
      required this.name,
      required this.cost,
      required this.categoryName,
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

List<MarketItem> menuItems = List.generate(
    20,
    (index) => MarketItem(
            id: getRandomString(10),
            name: 'Avocado',
            cost: 8.8,
            categoryName: "Fruit",
            isFavourite: true,
            image: 'avacado.png',
            rating: 4.5,
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
                ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
            discussion:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
                ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
            reviews: [
              Review(
                  name: 'Jhon Leo',
                  review:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                  rating: 4,
                  date: DateTime.now(),
                  image: 'assets/images/user1.png'),
              Review(
                  name: 'Logan Tucker',
                  review:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                  rating: 4,
                  date: DateTime.now(),
                  image: 'assets/images/user2.png'),
              Review(
                  name: 'Jasmine James',
                  review:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do'
                      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim',
                  rating: 4,
                  date: DateTime.now(),
                  image: 'assets/images/user3.png')
            ]));

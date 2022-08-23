import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';
import 'package:kedo_food/widgets/item_card_grid_display.dart';

import '../model/market_item.dart';

class WishList extends StatefulWidget {
  static const String routeName = 'WishList';
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    //scrollController.addListener(listener);
    super.initState();
  }

  // void listener() {
  //   var offset = scrollController.offset;
  //   //print("offset data $offset");
  //   if (offset > 140 && iconColor == Colors.white) {
  //     //print("offset data $offset");
  //     setState(() {
  //       iconColor = Colors.black;
  //     });
  //   } else if (offset < 140 && iconColor == Colors.black) {
  //     setState(() {
  //       iconColor = Colors.white;
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   scrollController.removeListener(listener);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List<MarketItem> menuItems = List.generate(
        20,
        (index) => MarketItem(
                name: 'Avocado',
                cost: 8.8,
                isFavourite: true,
                image: 'item-brocoli.png',
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          ListTile(
            iconColor: Colors.black,
            leading: AppBackButton(context),
            title: const Padding(
              padding: EdgeInsets.only(left: 65, top: 10),
              child: Text(
                "Wishlist",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
                controller: scrollController,
                slivers: [ItemCardsGridDisplay(menuItems: menuItems)]),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kedo_food/widgets/item_card_grid_display.dart';
import 'package:kedo_food/widgets/page_header.dart';

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
    
    return Scaffold(
      body: Column(
        children: [
          ...getPageHeader("Wishlist", context, titlePladding: 65),
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

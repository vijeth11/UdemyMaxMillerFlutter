import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/providers/cart_item_provider.dart';
import 'package:kedo_food/providers/products.dart';
import 'package:kedo_food/screens/cart_menu.dart';
import 'package:kedo_food/widgets/detail_tabs.dart';
import 'package:kedo_food/widgets/expandable_appbar.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  static const String routeName = 'ItemDetail';

  ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late MarketItem _marketItem;
  late PageController _pageController;
  double _leftRightPadding = 20.0;
  int quantity = 1;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          margin: const EdgeInsets.all(5),
          width: 35,
          height: 7,
          decoration: BoxDecoration(
              color:
                  currentIndex == index ? Colors.white : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(50),
              shape: BoxShape.rectangle),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _marketItem = ModalRoute.of(context)!.settings.arguments as MarketItem;
    return ExpandableAppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
              onPressed: () {
                // share the content
              },
              icon: const Icon(
                Icons.share,
                size: 40,
              )),
        )
      ],
      leading: AppBackButton(context),
      collapsedTitle: Text(
        _marketItem.name,
        style: const TextStyle(color: Colors.black),
      ),
      // Image carousal with rectangle indcator
      expandedTitleBackground: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
                itemCount: 3,
                pageSnapping: true,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(_marketItem.image),
                              fit: BoxFit.cover)),
                    )),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(3, activePage))
          ],
        ),
      ),
      appBody: SliverList(
          delegate: SliverChildListDelegate([
        // name of the category and the item
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_marketItem.image), fit: BoxFit.cover)),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: Container(
                    padding: EdgeInsets.only(
                        left: _leftRightPadding,
                        right: _leftRightPadding,
                        bottom: 15,
                        top: 30),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FRUITS',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          _marketItem.name,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        )
                      ],
                    )))),
        // Container for increasing the quantity
        Container(
          padding: EdgeInsets.only(
              left: _leftRightPadding, right: _leftRightPadding, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_marketItem.cost}',
                style: const TextStyle(
                    fontSize: 35,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 150,
                    color: Colors.grey.shade300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove, size: 30)),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            },
                            icon: const Icon(Icons.add, size: 30))
                      ],
                    ),
                  ))
            ],
          ),
        ),
        // Rating and user profile image
        Container(
          padding: EdgeInsets.only(
              left: _leftRightPadding, right: _leftRightPadding, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFFF8730),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${_marketItem.rating}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(${_marketItem.reviews.length} reviews)',
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  )
                ],
              ),
              if (_marketItem.reviews.isNotEmpty)
                Stack(
                  children: [...getTheReviewUserProfile()],
                )
            ],
          ),
        ),
        // Details and reviews tabs of the Item
        Container(
          padding: EdgeInsets.only(
              left: _leftRightPadding, right: _leftRightPadding, bottom: 15),
          child: DetailTabs(
            description: _marketItem.description,
            discussion: _marketItem.discussion,
            reviews: _marketItem.reviews,
          ),
        ),
      ])),
      displaySearchBar: false,
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(left: _leftRightPadding, right: _leftRightPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  onPressed: !_marketItem.isFavourite
                      ? () {
                          Provider.of<Products>(context, listen: false)
                              .addFavourite(_marketItem.id);
                        }
                      : null,
                  child: const Icon(
                    Icons.favorite,
                    size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<CartItemProvider>(context, listen: false)
                        .addItemToCart(_marketItem.id, quantity: quantity);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        CartMenu.routeName,
                        (route) => route.settings.name == "/");
                  },
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green.shade500),
                  child: Container(
                    height: 65,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'ADD TO CART',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text('\$ ${_marketItem.cost * 2}',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade300))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getTheReviewUserProfile() {
    List<Widget> images = [];
    int imagesLength =
        _marketItem.reviews.length >= 3 ? 3 : _marketItem.reviews.length;
    for (int i = 0; i < imagesLength; i++) {
      images.add(
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(left: i * 35),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_marketItem.reviews[0].userImage),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(50)),
        ),
      );
    }
    return images;
  }
}

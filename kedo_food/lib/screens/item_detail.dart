import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/widgets/expandable_appbar.dart';

class ItemDetail extends StatefulWidget {
  static const String routeName = 'ItemDetail';

  ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late MarketItem _marketItem;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
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
        expandedTitleBackground: PageView.builder(
            itemCount: 3,
            pageSnapping: true,
            itemBuilder: (context, index) => Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/item-brocoli.png'),
                          fit: BoxFit.cover)),
                )),
        appBody: SliverList(
            delegate: SliverChildListDelegate([
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/item-brocoli.png'),
                      fit: BoxFit.cover)),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 40.0, right: 40.0, bottom: 15, top: 30),
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
          Container(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${_marketItem.cost}',
                  style: TextStyle(
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
                              onPressed: () {},
                              icon: Icon(Icons.remove, size: 30)),
                          Text(
                            '4',
                            style: TextStyle(fontSize: 25),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 30))
                        ],
                      ),
                    ))
              ],
            ),
          )
        ])),
        displaySearchBar: false);
  }
}
